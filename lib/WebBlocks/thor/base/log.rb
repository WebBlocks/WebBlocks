require 'WebBlocks/thor/base'

module WebBlocks
  module Thor
    class Base
      no_commands do

        def log(level, message = '', color = nil, force_new_line = (message.to_s !~ /( |\t)\Z/))

          log_color_map = {
            :debug => :cyan,
            :fail => [:red, :bold],
            :warn => [:yellow]
          }

          if log_color_map.has_key? level
            log_color = log_color_map[level]
            if color.is_a? ::Array
              color << log_color
            elsif color
              color = [color, log_color]
            else
              color = log_color
            end
          end

          say message, color, force_new_line

        end

      end
    end
  end
end
