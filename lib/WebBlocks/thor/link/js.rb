require 'tsort'
require 'WebBlocks/thor/link'
require 'WebBlocks/strategy/js/link'

module WebBlocks
  module Thor
    class Link

      description = "Construct linked construct of JS files based on dependencies"
      desc "js", description
      long_desc description

      def js

        begin

          prepare_blocks!
          ::WebBlocks::Strategy::Js::Link.new(self, log).execute!

        rescue ::TSort::Cyclic => e

          log.fatal "Cycle detected with dependency load order"
          fail e, :red

        end
      end

    end
  end
end