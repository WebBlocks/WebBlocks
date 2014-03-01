require 'tsort'
require 'WebBlocks/thor/link'
require 'WebBlocks/strategy/compile/scss'

module WebBlocks
  module Thor
    class Compile

      description = "Compile linked SCSS files"
      desc "scss", description
      long_desc description

      def scss

        prepare_blocks!
        ::WebBlocks::Strategy::Compile::Scss.new(self, log).execute!

      end

    end
  end
end