require 'web_blocks/facade/base'
require 'web_blocks/structure/scss_file'

module WebBlocks
  module Facade
    class ScssFile < Base

      def handle name, attributes = {}, &block
        context.child_eval ::WebBlocks::Structure::ScssFile, name, attributes, block
      end

    end
  end
end

