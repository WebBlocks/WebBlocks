require 'tsort'
require 'WebBlocks/thor/link'
require 'WebBlocks/strategy/link/js'

module WebBlocks
  module Thor
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