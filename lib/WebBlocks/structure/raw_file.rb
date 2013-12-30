require 'WebBlocks/support/tree/leaf_node'
require 'WebBlocks/framework'

module WebBlocks
  module Structure
    class RawFile < ::WebBlocks::Support::Tree::LeafNode

      include WebBlocks::Framework

      set :required, true

      def resolved_path
        parent.resolved_path + (attributes.has_key?(:path) ? attributes[:path] : name)
      end

      def inspect
        {
          :name => name,
          :route => route,
          :resolved_path => resolved_path
        }
      end

    end
  end
end