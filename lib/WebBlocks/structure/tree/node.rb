require 'WebBlocks/structure/tree/base_node'
require 'WebBlocks/support/tree/child'
require 'WebBlocks/support/tree/parent'

module WebBlocks
  module Structure
    module Tree
      class Node < BaseNode

        include ::WebBlocks::Support::Tree::Child
        include ::WebBlocks::Support::Tree::Parent

      end
    end
  end
end