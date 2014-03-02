require 'web_blocks/product/concat_file/raw'

module WebBlocks
  module Product
    module ConcatFile
      class Js < Raw

        def content_for file
          ";#{super file};"
        end

      end
    end
  end
end