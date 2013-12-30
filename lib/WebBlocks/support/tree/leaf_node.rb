require 'WebBlocks/support/tree/attribute_node'

module WebBlocks

  module Support

    module Tree

      class LeafNode < AttributeNode

        attr_reader :name
        attr_reader :parent

        # Node depends
        set :dependencies, []

        # Node depends on loose dependencies only if the loose dependencies exist
        set :loose_dependencies, []

        # Explicitly required by framework.include
        set :required, false

        def initialize name, attributes = {}
          @name = name
          @parent = nil
          super attributes
        end

        def set_parent parent
          @parent = parent
          @parent.add_child self
        end

        def parents
          @parent ? @parent.parents.unshift(@parent) : []
        end

        def route *args
          val = parents.map{|parent| parent.name}.reverse + [name] + args
          val.shift
          val
        end

        def loose_dependency route
          push :loose_dependencies, route
        end

        def dependency route
          push :dependencies, route
        end

        def merge_branch_array_attribute attribute, method = nil
          parent ? (get(attribute) + parent.send(method || caller_locations(1,1)[0].label)) : get(attribute)
        end

        def resolve_dependencies
          merge_branch_array_attribute :dependencies
        end

        def resolve_loose_dependencies
          merge_branch_array_attribute :loose_dependencies
        end

        def run &block
          instance_eval &block
          self
        end

      end

    end

  end

end

