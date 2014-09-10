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
                if source.size > 0
                  begin
                    compressor = YUI::CssCompressor.new
                    silently do
                      product.write compressor.compress source
                    end
                  rescue YUI::Compressor::RuntimeError => e
                    log.warn { "YUI compressor returned error -- skipping" }
                    FileUtils.rm task.base_path + product_path
                  rescue => e
                    log.warn { "Unexpected error encountered -- skipping\n#{e}" }
                    FileUtils.rm task.base_path + product_path
                  end
                else
                  log.warn { "No CSS content -- skipping" }
                end
              end
            end

          end

        end

      end
    end
  end
end