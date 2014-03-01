require 'WebBlocks/structure/js_file'
require 'WebBlocks/product/concat_file/js'

module WebBlocks
  module Manager
    class JsLinker

      attr_reader :log

      def initialize task, log
        @task = task
        @log = log.scope 'Linker'
        @linker_file = ::WebBlocks::Product::ConcatFile::Js.new @task.base_path + '.blocks/workspace/js/blocks.js'
      end

      #TODO: Fix this to be friendly to parallel processes and partial generation rather than building full file in one loop
      def execute!

        log.info { "Starting" }

        @task.framework.get_file_load_order(::WebBlocks::Structure::JsFile).each do |file|
          log.debug do
            @linker_file.push file
            "Linked #{file.resolved_path}"
          end
        end

        log.debug do
          @linker_file.save!
          "Saved #{@linker_file.path}"
        end

        log.info { "Finished" }

      end

    end
  end
end