module WebBlocks
  module Support
    module Tree
      class AttributeNode

        @@attributes = {}

        def self.set name, value
          @@attributes[self.name] = {} unless @@attributes.has_key? self.name
          @@attributes[self.name][name] = value
        end

        def self.attributes
          @@attributes.has_key?(self.name) ? @@attributes[self.name] : {}
        end

        attr_reader :attributes

        def initialize attributes = {}
          @attributes = attributes
          process_attributes!
        end

        def get name
           @attributes[name]
        end

        def set name, value
          @attributes[name] = value
        end

        def has? name
          @attributes.has_key(name)
        end

        def push name, value
          @attributes[name] << value
        end

        def process_attributes!
          computed = {}
          self.class.ancestors.reverse.each do |klass|
            computed.merge! @@attributes[klass.to_s] if @@attributes.has_key? klass.to_s
          end
          computed.merge! @attributes
          @attributes = Marshal.load(Marshal.dump(computed)) # deep clone
        end

      end
    end
  end
end