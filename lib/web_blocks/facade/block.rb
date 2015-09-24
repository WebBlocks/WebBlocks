require 'web_blocks/structure/block'

module WebBlocks
  module Facade
    module Block

      def block name, attributes = {}, &block
        child_eval ::WebBlocks::Structure::Block, name, attributes, block
      end

    end
  end
end

