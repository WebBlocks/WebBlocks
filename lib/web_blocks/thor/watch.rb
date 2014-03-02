require 'web_blocks/thor/base'

module WebBlocks
  module Thor
    class Watch < Base

      default_task 'all'

    end
  end
end

Dir.glob(Pathname.new(__FILE__).parent.realpath + "watch/**/*.rb").each { |r| require r }