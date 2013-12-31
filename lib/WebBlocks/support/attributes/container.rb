module WebBlocks
  module Support
    module Attributes
      module Container

        def has? name
          attributes.has_key? name
        end

        def get name
          attributes[name]
        end

        def set name, value
          attributes name => value
        end

        def push name, value
          puts attributes[name]
          attributes[name] << value
        end

        def attributes hash = nil
          @attributes = class_attributes unless @attributes
          @attributes.merge! hash if hash
          @attributes
        end

        def class_attributes
          computed = {}
          self.class.ancestors.reverse.each do |klass|
            if self.class.respond_to?(:attributes) and self.class.attributes.has_key?(klass.to_s)
              computed.merge! self.class.attributes[klass.to_s]
            end
          end
          Marshal.load(Marshal.dump(computed)) # deep clone
        end

      end
    end
  end
end