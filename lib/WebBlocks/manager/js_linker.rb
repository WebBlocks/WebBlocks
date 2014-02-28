require 'WebBlocks/structure/js_file'
require 'WebBlocks/product/concat_file/js'

module WebBlocks
  module Manager
    class JsLinker

      def initialize framework, base_path
        @framework = framework
        @base_path = base_path
        @linker_file = ::WebBlocks::Product::ConcatFile::Js.new @base_path + '.blocks/workspace/js/blocks.js'
      end

      #TODO: Fix this to be friendly to parallel processes and partial generation rather than building full file in one loop
      def execute!

        @framework.get_file_load_order(::WebBlocks::Structure::JsFile).each do |file|
          @linker_file.push file
        end

        @linker_file.save!

      end

    end
  end
end