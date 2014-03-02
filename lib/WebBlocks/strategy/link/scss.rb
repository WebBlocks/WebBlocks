require 'WebBlocks/strategy/link/base'
require 'WebBlocks/structure/scss_file'
require 'WebBlocks/product/concat_file/scss'

module WebBlocks
  module Strategy
    module Link
      class Scss < Base

        def initialize task
          super task
          @log = task.log.scope 'SCSS - Link'
        end

        def product_path
          task.base_path + '.blocks/workspace/scss/blocks.scss'
        end

        def make_linker_file
          ::WebBlocks::Product::ConcatFile::Scss.new product_path
        end

        def compute_files_to_link
          task.root.get_file_load_order(::WebBlocks::Structure::ScssFile)
        end

      end
    end
  end
end