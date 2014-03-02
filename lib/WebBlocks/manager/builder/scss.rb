require 'WebBlocks/manager/builder/base'
require 'WebBlocks/strategy/link/scss'
require 'WebBlocks/strategy/compile/scss'

module WebBlocks
  module Manager
    module Builder
      class Scss < Base

        def execute!

          super do
            WebBlocks::Strategy::Link::Scss.new(task).execute!
            WebBlocks::Strategy::Compile::Scss.new(task).execute!
          end

        end

      end
    end
  end
end