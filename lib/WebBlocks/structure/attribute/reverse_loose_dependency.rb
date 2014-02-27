require 'WebBlocks/support/attributes/class/container'

module WebBlocks
  module Structure
    module Attribute
      module ReverseLooseDependency

        def reverse_loose_dependency route
          block = framework.block_from_route route
          block.loose_dependency self.route
        end

      end
    end
  end
end