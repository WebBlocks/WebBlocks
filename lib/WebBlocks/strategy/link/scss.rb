require 'WebBlocks/strategy/link/base'
require 'WebBlocks/structure/scss_file'
require 'WebBlocks/product/concat_file/scss'

module WebBlocks
  module Strategy
    module Link
      class Scss < Base

        def make_linker_file
          ::WebBlocks::Product::ConcatFile::Scss.new task.base_path + '.blocks/workspace/scss/blocks.scss'
        end

        def compute_files_to_link
          task.framework.get_file_load_order(::WebBlocks::Structure::ScssFile)
        end

      end
    end
  end
end