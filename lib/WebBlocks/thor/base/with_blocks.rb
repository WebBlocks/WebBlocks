require 'WebBlocks/thor/base/prepare'

module WebBlocks
  module Thor
    class Base

      no_commands do

        def with_blocks

          prepare!
          yield

        end

      end

    end
  end
end
