require 'web_blocks/facade/base'
require 'web_blocks/structure/js_file'

module WebBlocks
  module Facade
    class JsFile < Base

      def handle name, attributes = {}, &block
        context.child_eval ::WebBlocks::Structure::JsFile, name, attributes, block
      end

    end
  end
end

