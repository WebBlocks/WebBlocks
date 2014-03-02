require 'tsort'
require 'web_blocks/thor/partial/link'
require 'web_blocks/strategy/link/js'

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