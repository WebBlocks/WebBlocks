require 'tsort'
require 'WebBlocks/thor/link'
require 'WebBlocks/manager/js_linker'
require 'WebBlocks/manager/scss_linker'
require 'WebBlocks/manager/scss_compiler'

module WebBlocks
  module Thor
    class Build

      description = "Build all assets"
      desc "all", description
      long_desc description
      def all
        begin
          with_blocks do
            WebBlocks::Manager::JsLinker.new(self).execute!
            WebBlocks::Manager::ScssLinker.new(self).execute!
            WebBlocks::Manager::ScssCompiler.new(self).execute!
          end
        rescue ::TSort::Cyclic => e
          say "Cycle detected with dependency load order", [:red, :bold]
          fail e, :red
        end
      end

    end
  end
end