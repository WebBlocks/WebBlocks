require 'WebBlocks/support/attributes/class_container'

module WebBlocks
  module Structure
    module Attribute
      module LooseDependency

        class << self
          include ::WebBlocks::Support::Attributes::ClassContainer
        end

        set :loose_dependencies, []

        def loose_dependency route
          push :loose_dependencies, route
        end

        def resolve_loose_dependencies
          merge_branch_array_attribute :loose_dependencies
        end

      end
    end
  end
end