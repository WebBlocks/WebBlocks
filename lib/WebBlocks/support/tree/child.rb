module WebBlocks
  module Support
    module Tree
      module Child

        def set_parent parent
          @parent = parent
          @parent.add_child self
        end

        def parent
          @parent ||= nil
        end

        def parents
          parent ? parent.parents.unshift(parent) : []
        end

        def route *args
          val = parents.map{|parent| parent.name}.reverse + [name] + args
          val.shift
          val
        end

      end
    end
  end
end

