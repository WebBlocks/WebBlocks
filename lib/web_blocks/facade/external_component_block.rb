require 'web_blocks/facade/base'
require 'web_blocks/structure/block'

module WebBlocks
  module Facade
    class ExternalComponentBlock < Base

      def handle name, attributes = {}, &block
        if attributes.has_key?(:path)
          attributes[:path] = "bower_components/#{name}/#{attributes[:path]}"
        else
          attributes[:path] = "bower_components/#{name}"
        end
        context.block name, attributes, &block
      end

    end
  end
end

