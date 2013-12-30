require 'WebBlocks/thor/base'
require 'WebBlocks/structure/raw_file'
require 'WebBlocks/structure/scss_file'
require 'WebBlocks/structure/js_file'
require 'WebBlocks/structure/img_file'
require 'WebBlocks/structure/font_file'

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
