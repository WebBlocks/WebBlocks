require 'WebBlocks/structure/tree/leaf_node'
require 'WebBlocks/support/tree/parent'

module WebBlocks
  module Structure
    module Tree
      class Node < LeafNode

        include ::WebBlocks::Support::Tree::Parent

      end
    end
  end
end