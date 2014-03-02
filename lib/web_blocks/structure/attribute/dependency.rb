require 'web_blocks/support/attributes/class/container'

module WebBlocks
  module Structure
    module Attribute
      module Dependency

        class << self
          include ::WebBlocks::Support::Attributes::Class::Container
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