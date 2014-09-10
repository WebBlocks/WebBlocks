require 'web_blocks/thor/base'
require 'web_blocks/strategy/link/js'
require 'web_blocks/strategy/link/scss'

module WebBlocks
  module Thor
    module Partial
      class Link < Base

        description = "Construct linked construct of JS files based on dependencies"
        desc "js", description
        long_desc description

        def js

          prepare_blocks!
          ::WebBlocks::Strategy::Link::Js.new(self).execute!

        end

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

Dir.glob(Pathname.new(__FILE__).parent.realpath + "link/**/*.rb").each { |r| require r }