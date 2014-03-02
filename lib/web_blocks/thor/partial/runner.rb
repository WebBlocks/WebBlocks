require 'thor'
require 'web_blocks/thor/partial/link'
require 'web_blocks/thor/partial/compile'

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
