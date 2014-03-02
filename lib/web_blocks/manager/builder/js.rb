require 'fileutils'
require 'web_blocks/manager/builder/base'
require 'web_blocks/strategy/link/js'

module WebBlocks
  module Manager
    module Builder
      class Js < Base

        attr_reader :link_strategy

        def initialize task

          super task

          @link_strategy = WebBlocks::Strategy::Link::Js.new(task)

        end

        def execute!

          super do

            link_strategy.execute!

          end

        end

        def save!

          super do |build_path|

            log.info do

              js_build_path = build_path + task.root.get(:js_build_dir)
              FileUtils.mkdir_p js_build_path

              source_path = link_strategy.product_path
              product_path = js_build_path + source_path.basename
              FileUtils.copy source_path, product_path

              "Saved JS build #{product_path}"

            end

          end

        end

      end
    end
  end
end