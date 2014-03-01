require 'tsort'
require 'WebBlocks/thor/link'
require 'WebBlocks/manager/scss_compiler'

module WebBlocks
  module Thor
    class Compile

      description = "Compile linked SCSS files"
      desc "scss", description
      long_desc description

      def scss

        begin

          prepare_blocks!
          ::WebBlocks::Manager::ScssCompiler.new(self).execute!

        rescue ::TSort::Cyclic => e

          log.fatal "Cycle detected with dependency load order"
          fail e, :red

        end

      end

    end
  end
end