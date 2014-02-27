require 'thor'
require 'WebBlocks/thor/inspect'

module WebBlocks
  module Thor
    class Runner < ::Thor
      register ::WebBlocks::Thor::Inspect, :inspect, "inspect", "Inspect the blocks configuration and tree"
    end
  end
end
