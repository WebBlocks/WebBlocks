require 'WebBlocks/structure/tree/base_node'
require 'WebBlocks/support/tree/child'

module WebBlocks
  module Structure
    module Tree
      class LeafNode < BaseNode

        include ::WebBlocks::Support::Tree::Child

      end
    end
  end
end