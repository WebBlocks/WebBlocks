require 'WebBlocks/manager/builder/base'
require 'WebBlocks/strategy/js/link'

module WebBlocks
  module Manager
    module Builder
      class Js < Base

        def execute!

          super do
            WebBlocks::Strategy::Js::Link.new(task, log).execute!
          end

        end

      end
    end
  end
end