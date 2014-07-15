require 'web_blocks/thor/base'
require 'web_blocks/strategy/compile/scss'

module WebBlocks
  module Thor
    module Partial
      class Compile < Base

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

Dir.glob(Pathname.new(__FILE__).parent.realpath + "compile/**/*.rb").each { |r| require r }