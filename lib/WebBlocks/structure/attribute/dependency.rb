require 'WebBlocks/support/attributes/class_container'

module WebBlocks
  module Structure
    module Attribute
      module Dependency

        class << self
          include ::WebBlocks::Support::Attributes::ClassContainer
        end

        set :dependencies, []

        def dependency route
          push :dependencies, route
        end

        def resolve_dependencies
          merge_branch_array_attribute :dependencies
        end

      end
    end
  end
end