require 'WebBlocks/structure/js_file'
require 'WebBlocks/product/concat_file/js'

module WebBlocks
  module Manager
    class JsLinker

      def initialize task
        @task = task
        @linker_file = ::WebBlocks::Product::ConcatFile::Js.new @task.base_path + '.blocks/workspace/js/blocks.js'
      end

      #TODO: Fix this to be friendly to parallel processes and partial generation rather than building full file in one loop
      def execute!

        @task.log :operation, "Linking Javscript"

        @task.framework.get_file_load_order(::WebBlocks::Structure::JsFile).each do |file|
          @task.log :debug, "- #{file.resolved_path}"
          @linker_file.push file
        end

        @linker_file.save!
        @task.log :debug, "Saved #{@linker_file.path}"

      end

    end
  end
end