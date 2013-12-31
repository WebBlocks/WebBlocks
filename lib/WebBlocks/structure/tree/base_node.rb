require 'WebBlocks/support/attributes/class/container'
require 'WebBlocks/support/attributes/container'
require 'WebBlocks/support/class/extend_method'
require 'WebBlocks/support/tree/node'

module WebBlocks
  module Structure
    module Tree

      class BaseNode

        class << self
          include ::WebBlocks::Support::Attributes::Class::Container
          include ::WebBlocks::Support::Class::ExtendMethod
        end

        include ::WebBlocks::Support::Attributes::Container
        include ::WebBlocks::Support::Tree::Node

        extend_method :initialize do |name, attributes = {}|
          previous name
          self.attributes attributes
        end

        def merge_branch_array_attribute attribute, method = nil
          parent ? (get(attribute) + parent.send(method || caller_locations(1,1)[0].label)) : get(attribute)
        end

        def run &block
          instance_eval &block
          self
        end

      end
    end
  end
end