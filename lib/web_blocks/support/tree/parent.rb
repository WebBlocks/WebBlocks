module WebBlocks
  module Support
    module Tree
      module Parent

        def add_child child
          key = child.respond_to?(:name) ? child.name : child
          return if has_child? key
          @children ||= {}
          @children[key] = child
          child.set_parent(self) if child.respond_to?(:set_parent)
        end

        def children
          @children || {}
        end

        def has_child? name
          children.has_key? name
        end

        def remove_child child
          name = child.respond_to?(:name) ? child.name : child
          children.delete name if has_child? name
        end

        def remove_all_children
          @children = {}
        end

      end
    end
  end
end

