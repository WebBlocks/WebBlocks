require 'thor'
require 'WebBlocks/thor/inspect'
require 'WebBlocks/thor/link'
require 'WebBlocks/thor/compile'
require 'WebBlocks/thor/build'

module WebBlocks
  module Thor
    class Runner < ::Thor
      register ::WebBlocks::Thor::Inspect, :inspect, "inspect", "Inspect the blocks configuration and tree"
      register ::WebBlocks::Thor::Link, :link, "link", "Linker that prepares assets for compilation"
      register ::WebBlocks::Thor::Compile, :compile, "compile", "Compiler that builds assets from linked sources"
      register ::WebBlocks::Thor::Build, :build, "build", "Link, compile and optimize all assets"
    end
  end
end
