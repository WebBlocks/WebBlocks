require 'WebBlocks/strategy/link/base'
require 'WebBlocks/structure/js_file'
require 'WebBlocks/product/concat_file/js'

module WebBlocks
  module Strategy
    module Link
      class Js < Base

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