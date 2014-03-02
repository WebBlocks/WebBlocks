require 'WebBlocks/manager/builder/base'
require 'WebBlocks/strategy/link/js'

module WebBlocks
  module Manager
    module Builder
      class Js < Base

        def execute!

          super do
            WebBlocks::Strategy::Link::Js.new(task).execute!
          end

        end

      end
    end
  end
end