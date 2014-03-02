require 'web_blocks/strategy/link/base'
require 'web_blocks/structure/js_file'
require 'web_blocks/product/concat_file/js'

module WebBlocks
  module Strategy
    module Link
      class Js < Base

        def initialize task
          super task
          @log = task.log.scope 'JS - Link'
        end

        def product_path
          task.base_path + '.blocks/workspace/js/blocks.js'
        end

        def make_linker_file
          ::WebBlocks::Product::ConcatFile::Js.new product_path
        end

        def compute_files_to_link
          task.root.get_file_load_order(::WebBlocks::Structure::JsFile)
        end

      end
    end
  end
end