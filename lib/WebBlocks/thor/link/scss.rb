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
          with_blocks { ::WebBlocks::Manager::ScssLinker.new(self).execute! }
        rescue ::TSort::Cyclic => e
          say "Cycle detected with dependency load order", [:red, :bold]
          fail e, :red
        end
      end

    end
  end
end