require 'web_blocks/support/attributes/class/container'

module WebBlocks
  module Structure
    module Attribute
      module LooseDependency

        class << self
          include ::WebBlocks::Support::Attributes::Class::Container
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