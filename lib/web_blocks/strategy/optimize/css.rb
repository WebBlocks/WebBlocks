require 'web_blocks/strategy/optimize/base'
require 'yui/compressor'

module WebBlocks
  module Strategy
    module Optimize
      class Css < Base

        def initialize task

          super task

          @log = task.log.scope 'CSS - Optimize'
          @product_path = task.base_path + '.blocks/workspace/css/blocks.min.css'
          @source_path = task.base_path + '.blocks/workspace/css/blocks.css'

        end

        def execute!

          super do

            File.open task.base_path + product_path, 'w' do |product|
              File.open task.base_path + source_path, 'r' do |source|
                compressor = YUI::CssCompressor.new
                product.write compressor.compress source
              end
            end

          end

        end

      end
    end
  end
end