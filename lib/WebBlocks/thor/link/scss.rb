require 'WebBlocks/thor/link'
require 'WebBlocks/strategy/link/scss'

module WebBlocks
  module Thor
    class Link

      description = "Construct linked construct of SCSS files based on dependencies"
      desc "scss", description
      long_desc description

      def scss

        prepare_blocks!
        ::WebBlocks::Strategy::Link::Scss.new(self, log).execute!

      end

    end
  end
end