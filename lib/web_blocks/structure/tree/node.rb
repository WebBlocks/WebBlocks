require 'web_blocks/structure/tree/leaf_node'
require 'web_blocks/support/tree/parent'

module WebBlocks
  module Structure
    module Tree
      class Node < LeafNode

        include ::WebBlocks::Support::Tree::Parent

      end
    end
  end
end