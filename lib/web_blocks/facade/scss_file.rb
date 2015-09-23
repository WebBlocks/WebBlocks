require 'web_blocks/structure/scss_file'

module WebBlocks
  module Facade
    module ScssFile

      def scss_file name, attributes = {}, &block
        child_eval ::WebBlocks::Structure::ScssFile, name, attributes, block
      end

    end
  end
end

