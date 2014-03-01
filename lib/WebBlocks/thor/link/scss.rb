require 'tsort'
require 'WebBlocks/thor/link'
require 'WebBlocks/manager/scss_linker'

module WebBlocks
  module Thor
    class Link

      description = "Construct linked construct of SCSS files based on dependencies"
      desc "scss", description
      long_desc description

      def scss

        begin

          prepare_blocks!
          ::WebBlocks::Manager::ScssLinker.new(self).execute!

        rescue ::TSort::Cyclic => e

          log.fatal "Cycle detected with dependency load order"
          fail e, :red

        end

      end

    end
  end
end