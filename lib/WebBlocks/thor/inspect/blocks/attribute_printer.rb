require 'WebBlocks/thor/inspect/blocks/printer'

module WebBlocks
  module Thor
    class Inspect
      no_commands do
        module Blocks
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
        end
      end
    end
  end
end