require 'tsort'
require 'web_blocks/thor/partial/link'
require 'web_blocks/strategy/compile/scss'

module WebBlocks
  module Thor
    module Partial
      class Compile

        description = "Compile linked SCSS files"
        desc "scss", description
        long_desc description

        def scss

          prepare_blocks!
          ::WebBlocks::Strategy::Compile::Scss.new(self).execute!

        end

      end
    end
  end
end