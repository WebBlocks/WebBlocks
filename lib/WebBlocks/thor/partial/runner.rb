require 'thor'
require 'WebBlocks/thor/partial/link'
require 'WebBlocks/thor/partial/compile'

module WebBlocks
  module Thor
    module Partial
      class Runner < ::Thor
        register ::WebBlocks::Thor::Partial::Link, :link, "link", "Linker that prepares assets for compilation"
        register ::WebBlocks::Thor::Partial::Compile, :compile, "compile", "Compiler that builds assets from linked sources"
      end
    end
  end
end
