require 'pathname'

module WebBlocks
  module Structure; end
end

Dir.glob(Pathname.new(__FILE__).parent.realpath + "structure/**/*.rb").each { |r| require r }