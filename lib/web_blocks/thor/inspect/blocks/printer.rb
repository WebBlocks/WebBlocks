module WebBlocks
  module Thor
    class Inspect
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
        end
      end
    end
  end
end