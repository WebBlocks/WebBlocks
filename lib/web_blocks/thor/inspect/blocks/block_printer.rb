require 'web_blocks/thor/inspect/blocks/printer'
require 'web_blocks/thor/inspect/blocks/attribute_printer'

module WebBlocks
  module Thor
    class Inspect
      no_commands do
        module Blocks
          class BlockPrinter < Printer

            def initialize block, options
              super options
              @block = block
            end

            def print_name!
              say "#{@block.name} (#{@block.class.name.split('::')[-1]})", (@block.respond_to?(:children) ? :bold : [])
            end

            def print_attributes!
              @block.attributes.each do |key, value|
                AttributePrinter.new(key, value, @options).print!
              end
            end

            def print_children!
              @block.children.each do |_, child|
                self.class.new(child, @options).print!
              end
            end

            def print!
              print_name!
              print_attributes! if @options[:attributes]
              print_children! if @block.respond_to? :children
            end

          end
        end
      end
    end
  end
end