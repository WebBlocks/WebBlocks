require 'WebBlocks/thor/base'

module WebBlocks
  module Thor
    class Compile < Base

    end
  end
end

Dir.glob(Pathname.new(__FILE__).parent.realpath + "compile/**/*.rb").each { |r| require r }