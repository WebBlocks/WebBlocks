require 'web_blocks/structure/js_file'

module WebBlocks
  module Facade
    module JsFile

      def js_file name, attributes = {}, &block
        child_eval ::WebBlocks::Structure::JsFile, name, attributes, block
      end

    end
  end
end

