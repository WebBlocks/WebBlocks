require 'web_blocks/thor/base'

module WebBlocks
  module Thor
    module Partial
      class Link < Base

      end
    end
  end
end

Dir.glob(Pathname.new(__FILE__).parent.realpath + "link/**/*.rb").each { |r| require r }