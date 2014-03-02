require 'thor'
require 'web_blocks/framework'

module WebBlocks
  module Thor
    class Base < ::Thor
      include ::WebBlocks::Framework
    end
  end
end

Dir.glob(Pathname.new(__FILE__).parent.realpath + "base/**/*.rb").each { |r| require r }
