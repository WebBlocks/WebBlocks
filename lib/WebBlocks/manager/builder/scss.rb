require 'WebBlocks/manager/builder/base'
require 'WebBlocks/strategy/scss/link'
require 'WebBlocks/strategy/scss/compile'

module WebBlocks
  module Manager
    module Builder
      class Scss < Base

        def execute!

          super do
            WebBlocks::Strategy::Scss::Link.new(task, log).execute!
            WebBlocks::Strategy::Scss::Compile.new(task, log).execute!
          end

        end

      end
    end
  end
end