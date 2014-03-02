require 'web_blocks/manager/builder/base'
require 'web_blocks/strategy/link/scss'
require 'web_blocks/strategy/compile/scss'

module WebBlocks
  module Manager
    module Builder
      class Scss < Base

        attr_reader :link_strategy
        attr_reader :compile_strategy

        def initialize task

          super task

          @link_strategy = WebBlocks::Strategy::Link::Scss.new(task)
          @compile_strategy = WebBlocks::Strategy::Compile::Scss.new(task)

        end

        def execute!

          super do

            link_strategy.execute!
            compile_strategy.execute!

          end

        end

        def save!

          super do |build_path|

            log.info do

              css_build_path = build_path + task.root.get(:css_build_dir)
              FileUtils.mkdir_p css_build_path

              source_path = compile_strategy.product_path
              product_path = css_build_path + source_path.basename
              FileUtils.copy source_path, product_path

              "Saved CSS build #{product_path}"

            end

          end

        end

      end
    end
  end
end