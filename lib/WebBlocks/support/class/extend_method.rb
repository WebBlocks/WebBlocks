require 'WebBlocks/support/attributes/class_container'
require 'WebBlocks/support/attributes/container'

module WebBlocks
  module Support
    module Class
      module ExtendMethod

        class ExtendMethodStrategy

          attr_reader :method_name
          attr_reader :previous_method_name
          attr_reader :previous_method
          attr_reader :block

          def initialize klass, method_name, block

            @class = klass
            @method_name = method_name
            @previous_method_name = :previous
            @block = block

            begin
              @previous_method = @class.instance_method(@method_name)
            rescue NameError => e
              @previous_method = e
            end

            @instance = nil
            @previous_method_original = nil

          end

          def bind! instance

            @instance = instance

          end

          def bound?

            !@instance.nil?

          end

          def unbind!

            @instance = nil

          end

          def save_state!

            raise 'Instance state already saved' if saved_state?

            if @instance.class.method_defined?(previous_method_name)
              @previous_method_original = @instance.class.send(:instance_method, previous_method_name)
            else
              @previous_method_original = false
            end

          end

          def saved_state?

            raise 'No bound instance' unless bound?

            !@previous_method_original.nil?

          end

          def restore_state!

            raise 'Instance state not saved' unless saved_state?

            @instance.class.send(:remove_method, previous_method_name)
            @instance.class.send(:define_method, previous_method_name, @previous_method_original) if @previous_method_original
            @previous_method_original = nil

          end

          def run! *args

            @instance.instance_exec *args, &block

          end

          def prepare!

            method_name = @method_name
            previous_method = @previous_method

            @instance.class.send(:define_method, previous_method_name) do |*args|
              unless previous_method.is_a? NameError
                previous_method.bind(self).call(*args)
              else
                raise NameError.new "undefined method `previous' in `extend_method' because `#{method_name}' is not previously defined for class `#{self.class.name}'"
              end
            end

          end

          def execute!

            strategy = self

            @class.send(:define_method, method_name) do |*args|

              strategy.bind! self
              strategy.save_state!
              strategy.prepare!
              strategy.run! *args
              strategy.restore_state!
              strategy.unbind!

            end

          end

        end

        def extend_method method_name, &block
          ExtendMethodStrategy.new(self, method_name, block).execute!
        end

      end
    end
  end
end