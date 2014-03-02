require 'tsort'
require 'WebBlocks/thor/partial/link'
require 'WebBlocks/strategy/link/js'

module WebBlocks
  module Thor
    module Partial
      class Link

        description = "Construct linked construct of JS files based on dependencies"
        desc "js", description
        long_desc description

        def js

          prepare_blocks!
          ::WebBlocks::Strategy::Link::Js.new(self).execute!

        end
      end
    end
  end
end