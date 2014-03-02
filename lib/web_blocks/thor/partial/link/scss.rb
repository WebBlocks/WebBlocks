require 'web_blocks/thor/partial/link'
require 'web_blocks/strategy/link/scss'

module WebBlocks
  module Thor
    module Partial
      class Link

        description = "Construct linked construct of SCSS files based on dependencies"
        desc "scss", description
        long_desc description

        def scss

          prepare_blocks!
          ::WebBlocks::Strategy::Link::Scss.new(self).execute!

        end

      end
    end
  end
end