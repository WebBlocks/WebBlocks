require 'web_blocks/thor/base'

module WebBlocks
  module Thor
    module Partial
      class Compile < Base

      end
    end
  end
end

Dir.glob(Pathname.new(__FILE__).parent.realpath + "compile/**/*.rb").each { |r| require r }