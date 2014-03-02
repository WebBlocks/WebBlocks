require 'web_blocks/thor/base'

module WebBlocks
  module Thor
    class Inspect < Base

    end
  end
end

Dir.glob(Pathname.new(__FILE__).parent.realpath + "inspect/**/*.rb").each { |r| require r }