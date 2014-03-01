require 'tsort'
require 'WebBlocks/thor/link'
require 'WebBlocks/strategy/link/scss'

module WebBlocks
  module Thor
    class Link

      description = "Construct linked construct of SCSS files based on dependencies"
      desc "scss", description
      long_desc description

      def scss

        begin

          prepare_blocks!
          ::WebBlocks::Strategy::Link::Scss.new(self, log).execute!

        rescue ::TSort::Cyclic => e

          log.fatal "Cycle detected with dependency load order"
          fail e, :red

        end

      end

    end
  end
end