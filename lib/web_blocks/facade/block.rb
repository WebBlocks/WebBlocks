require 'web_blocks/facade/base'
require 'web_blocks/structure/block'

module WebBlocks
  module Facade
    class Block < Base

      def handle name, attributes = {}, &block
        context.child_eval ::WebBlocks::Structure::Block, name, attributes, block
      end

    end
  end
end

