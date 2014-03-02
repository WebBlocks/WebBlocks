module WebBlocks
  module Support
    module Tree
      module Child

        def set_parent parent
          @parent = parent
          @parent.add_child(self) if @parent.respond_to?(:add_child)
        end

        def parent
          @parent ||= nil
        end

        def parents
          parent ? parent.parents.unshift(parent) : []
        end

      end
    end
  end
end

