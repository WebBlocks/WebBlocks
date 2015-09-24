require 'web_blocks/structure/block'

module WebBlocks
  module Facade
    module ExternalComponentBlock

      def external_component_block name, attributes = {}, &block
        if attributes.has_key?(:path)
          attributes[:path] = "bower_components/#{name}/#{attributes[:path]}"
        else
          attributes[:path] = "bower_components/#{name}"
        end
        self.block name, attributes, &block
      end

    end
  end
end

