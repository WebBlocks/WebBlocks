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
          with_blocks { WebBlocks::Manager::ScssCompiler.new(self).execute! }
        rescue ::TSort::Cyclic => e
          say "Cycle detected with dependency load order", [:red, :bold]
          fail e, :red
        end
      end

    end
  end
end