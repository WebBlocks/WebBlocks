require 'tsort'

module WebBlocks
  module Support
    module TSort
      class Hash < ::Hash

        class << self
          def try_convert original
            converted = self.new
            super(original).each do |key, value|
              converted[key] = value
            end
            converted
          end
        end

        include ::TSort

        alias tsort_each_node each_key

        def tsort_each_child(node, &block)
          fetch(node).each(&block)
        end

      end
    end
  end
end