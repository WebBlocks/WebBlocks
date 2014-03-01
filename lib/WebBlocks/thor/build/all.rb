require 'tsort'
require 'WebBlocks/thor/link'
require 'WebBlocks/manager/js_linker'
require 'WebBlocks/manager/scss_linker'
require 'WebBlocks/manager/scss_compiler'
require 'fork'

class Fork

end

module WebBlocks
  module Thor
    class Build



      description = "Build all assets"
      desc "all", description
      long_desc description

      def all

        begin

          prepare_blocks!

          task = self

          scss = Fork.execute :return do
            @log.thread_name = "SCSS"
            WebBlocks::Manager::ScssLinker.new(task).execute!
            WebBlocks::Manager::ScssCompiler.new(task).execute!
            true
          end

          js = Fork.execute :return do
            @log.thread_name = "JS"
            WebBlocks::Manager::JsLinker.new(task).execute!
            true
          end

          scss.return_value
          js.return_value

        rescue ::TSort::Cyclic => e

          say "Cycle detected with dependency load order", [:red, :bold]
          fail e, :red

        end

      end

    end
  end
end