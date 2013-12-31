require 'WebBlocks/support/attributes/class_container'
require 'WebBlocks/support/attributes/container'

module WebBlocks
  module Support
    module Class
      module ExtendMethod

        def extend_method method_name, &block

          begin
            original_method = instance_method(method_name)
          rescue NameError => e
            original_method = e
          end

          parent_method_name = :previous

          define_method method_name do |*args|

            old_parent_method = self.class.method_defined?(parent_method_name) ? self.class.send(:instance_method, parent_method_name) : nil

            self.class.send(:define_method, parent_method_name) do |*args|
              unless original_method.is_a? NameError
                original_method.bind(self).call(*args)
              else
                raise NameError.new "undefined method `previous' in `extend_method' because `#{method_name}' not previously defined for class `#{self.class.name}'"
              end
            end

            instance_exec *args, &block

            self.class.send(:remove_method, parent_method_name)

            self.class.send(:define_method, parent_method_name, old_parent_method) if old_parent_method

          end

        end

      end
    end
  end
end