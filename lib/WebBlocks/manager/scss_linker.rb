require 'WebBlocks/structure/scss_file'
require 'WebBlocks/product/concat_file/scss'

module WebBlocks
  module Manager
    class ScssLinker

      def initialize task
        @task = task
        @linker_file = ::WebBlocks::Product::ConcatFile::Scss.new @task.base_path + '.blocks/workspace/scss/blocks.scss'
      end

      #TODO: Fix this to be friendly to parallel processes and partial generation rather than building full file in one loop
      def execute!

        @task.log.info "Linking SCSS"

        @task.framework.get_file_load_order(::WebBlocks::Structure::ScssFile).each do |file|
          @task.log.debug "Linker" do
            @linker_file.push file
            "Linked #{file.resolved_path}"
          end
        end

        @linker_file.save!
        @task.log.debug("Linker") { "Saved #{@linker_file.path}" }
        
      end

    end
  end
end