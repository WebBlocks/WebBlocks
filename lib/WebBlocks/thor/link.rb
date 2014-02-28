require 'WebBlocks/thor/base'

module WebBlocks
  module Thor
    class Link < Base

    end
  end
end

Dir.glob(Pathname.new(__FILE__).parent.realpath + "link/**/*.rb").each { |r| require r }