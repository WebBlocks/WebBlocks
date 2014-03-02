require 'web_blocks/framework'
require 'web_blocks/structure/tree/leaf_node'
require 'web_blocks/structure/attribute/dependency'
require 'web_blocks/structure/attribute/loose_dependency'

module WebBlocks
  module Structure
    class RawFile < ::WebBlocks::Structure::Tree::LeafNode

      include WebBlocks::Framework
      include WebBlocks::Structure::Attribute::Dependency
      include WebBlocks::Structure::Attribute::LooseDependency

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