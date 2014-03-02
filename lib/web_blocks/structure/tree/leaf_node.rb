require 'extend_method'
require 'web_blocks/support/attributes/class/container'
require 'web_blocks/support/attributes/container'
require 'web_blocks/support/tree/node'
require 'web_blocks/support/tree/child'

module WebBlocks
  module Structure
    module Tree
      class LeafNode

        class << self
          include ::ExtendMethod
          include ::WebBlocks::Support::Attributes::Class::Container
        end

        include ::WebBlocks::Support::Attributes::Container
        include ::WebBlocks::Support::Tree::Node
        include ::WebBlocks::Support::Tree::Child

        extend_method :initialize do |name, attributes = {}|
          parent_method name
          self.attributes attributes
        end

        def route *args
          val = parents.map{|parent| parent.name}.reverse + [name] + args
          val.shift
          val
        end

        def merge_branch_array_attribute attribute, method = nil
          parent ? (get(attribute) + parent.send(method || caller[0][/`([^']*)'/, 1])) : get(attribute)
        end

        def run &block
          instance_eval &block
          self
        end

      end
    end
  end
end