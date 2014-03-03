require 'web_blocks/strategy/optimize/base'
require 'yui/compressor'

module WebBlocks
  module Strategy
    module Optimize
      class Js < Base

        def initialize task

          super task

          @log = task.log.scope 'JS - Optimize'
          @product_path = task.base_path + '.blocks/workspace/js/blocks.min.js'
          @source_path = task.base_path + '.blocks/workspace/js/blocks.js'

        end

        def execute!

          super do

            File.open task.base_path + product_path, 'w' do |product|
              File.open task.base_path + source_path, 'r' do |source|
                compressor = YUI::JavaScriptCompressor.new
                product.write compressor.compress source
              end
            end

          end

        end

      end
    end
  end
end