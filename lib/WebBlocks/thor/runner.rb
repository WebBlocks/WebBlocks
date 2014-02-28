require 'thor'
require 'WebBlocks/thor/inspect'
require 'WebBlocks/thor/link'
require 'WebBlocks/thor/compile'

module WebBlocks
  module Thor
    class Runner < ::Thor
      register ::WebBlocks::Thor::Inspect, :inspect, "inspect", "Inspect the blocks configuration and tree"
      register ::WebBlocks::Thor::Link, :link, "link", "Linker that prepares assets for compilation"
      register ::WebBlocks::Thor::Compile, :compile, "compile", "Compiler that builds assets from linked sources"
    end
  end
end
