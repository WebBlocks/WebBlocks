require 'web_blocks/thor/base'
require 'web_blocks/structure/raw_file'
require 'web_blocks/structure/scss_file'
require 'web_blocks/structure/js_file'
require 'web_blocks/structure/img_file'
require 'web_blocks/structure/font_file'

module WebBlocks
  module Thor
    class Base
      class << self

        def type_get_class_from_string string
          string = string.downcase if string
          case string
            when 'all'
              ::WebBlocks::Structure::RawFile
            when 'scss'
              ::WebBlocks::Structure::ScssFile
            when 'js'
              ::WebBlocks::Structure::JsFile
            when 'img'
              ::WebBlocks::Structure::ImgFile
            when 'font'
              ::WebBlocks::Structure::FontFile
            when nil
              ::WebBlocks::Structure::RawFile
            else
              raise "invalid type `#{string}' specified"
          end
        end

      end
    end
  end
end
