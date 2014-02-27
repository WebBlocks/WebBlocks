require 'WebBlocks/support/attributes/class/container'

module WebBlocks
  module Structure
    module Attribute
      module ReverseDependency

        def reverse_dependency route
          block = framework.block_from_route route
          block.dependency self.route
        end

      end
    end
  end
end