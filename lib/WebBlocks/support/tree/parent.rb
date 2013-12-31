module WebBlocks
  module Support
    module Tree
      module Parent

        def add_child child
          return if has_child? child.name
          @children ||= {}
          @children[child.name] = child
          child.set_parent self
        end

        def children
          @children || {}
        end

        def has_child? name
          children.has_key? name
        end

        def remove_child child
          name = child.respond_to?(name) ? child.name : child
          children.remove name if has_child? name
        end

      end
    end
  end
end

