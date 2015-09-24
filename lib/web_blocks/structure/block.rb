require 'web_blocks/facade/block'
require 'web_blocks/facade/js_file'
require 'web_blocks/facade/scss_file'
require 'web_blocks/structure/block_core'

module WebBlocks
  module Structure
    class Block < BlockCore

      set :required, false

      register_facade :block, WebBlocks::Facade::Block
      register_facade :js_file, WebBlocks::Facade::JsFile
      register_facade :scss_file, WebBlocks::Facade::ScssFile


    end
  end
end