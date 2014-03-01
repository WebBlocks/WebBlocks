require 'tsort'
require 'WebBlocks/thor/link'
require 'WebBlocks/manager/js_linker'
require 'WebBlocks/manager/scss_linker'
require 'WebBlocks/manager/scss_compiler'
require 'thread/future'

module WebBlocks
  module Thor
    class Build

      description = "Build all assets"
      desc "all", description
      long_desc description

      def all

        begin

          with_blocks do

            task = self

            scss = Thread.future {
              @log.thread_name = "SCSS"
              WebBlocks::Manager::ScssLinker.new(task).execute!
              WebBlocks::Manager::ScssCompiler.new(task).execute!
            }

            js = Thread.future {
              @log.thread_name = "JS"
              WebBlocks::Manager::JsLinker.new(task).execute!
            }

            ~scss
            ~js

          end

        rescue ::TSort::Cyclic => e

          log.fatal "Cycle detected with dependency load order"
          fail e, :red

        end

      end

    end
  end
end