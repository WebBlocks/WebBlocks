require 'web_blocks/thor/inspect'

module WebBlocks
  module Thor
    class Inspect

      blocks_desc = 'List of registered blocks, optionally with attributes and filtered to a route'
      desc "blocks", blocks_desc
      long_desc blocks_desc
      method_option :route, :type => :array, :default => [], :desc => 'Route to block to print'
      method_option :attributes, :type => :boolean, :default => false, :desc => 'Show block attributes'

      def blocks

        prepare_blocks!

        Blocks::BlockPrinter.new(
          root.block_from_route(options.route),
          :attributes => options[:attributes]
        ).print!

      end

      no_commands do
        module Blocks

          class Printer

            def initialize options
              @options = options.clone
              @options[:depth] = 0 unless @options.has_key?(:depth)
              @options[:depth] = @options[:depth] + 1
              @shell = ::WebBlocks::Thor::Inspect::Shell::Color.new
            end

            def say(message = '', color = nil, force_new_line = (message.to_s !~ /( |\t)\Z/))
              @shell.say Array.new(@options[:depth]).join('  ') + message, color, force_new_line
            end

          end

          class AttributePrinter < Printer

            def initialize key, value, options
              super options
              @value = value
              @key_string = parse_key(key)
              @value_string = parse_value(value)
            end

            def parse_key key
              ":#{key}"
            end

            def parse_value value
              if @value.is_a?(::Array) or @value.is_a?(::Hash)
                value.size > 0 ? value : nil
              elsif value.is_a?(::String)
                "\"#{value}\""
              elsif value.is_a?(::TrueClass)
                "true"
              elsif value.is_a?(::FalseClass)
                "false"
              else
                nil
              end
            end

            def color
              @value ? [:green] : [:red]
            end

            def print!
              say("#{@key_string} = #{@value_string}", color) if @value_string
            end

          end

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