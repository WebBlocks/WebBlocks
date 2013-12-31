module WebBlocks
  module Support
    module Attributes
      module ClassContainer

        def set name, value
          attributes[self.name] = {} unless attributes.has_key? self.name
          attributes[self.name][name] = value
        end

        def attributes name = nil
          if name
            @@attributes.has_key?(name) ? @@attributes[name] : {}
          else
            @@attributes ||= {}
          end
        end

      end
    end
  end
end