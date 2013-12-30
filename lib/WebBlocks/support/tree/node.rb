require 'WebBlocks/support/tree/leaf_node'

module WebBlocks

  module Support

    module Tree

      class Node < LeafNode

        attr_reader :children

        def initialize name, options = {}
          super name, options
          @children = {}
        end

        def add_child child
          return if has_child? child.name
          @children[child.name] = child
          child.set_parent self
        end

        def remove_child child
          name = child.respond_to?(name) ? child.name : child
          @children.remove name if has_child? name
        end

        def has_child? name
          @children.has_key? name
        end

      end

    end

  end

end

