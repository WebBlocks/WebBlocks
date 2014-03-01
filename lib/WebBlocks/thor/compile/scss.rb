require 'tsort'
require 'WebBlocks/thor/link'
require 'WebBlocks/strategy/compile/scss'

module WebBlocks
  module Thor
    class Compile

      description = "Compile linked SCSS files"
      desc "scss", description
      long_desc description

      def scss

        begin

          prepare_blocks!
          ::WebBlocks::Strategy::Compile::Scss.new(self, log).execute!

        rescue ::TSort::Cyclic => e

          log.fatal "Cycle detected with dependency load order"
          fail e, :red

        end

      end

    end
  end
end