require 'web_blocks/thor/base'

module WebBlocks
  module Thor
    class Base
      class << self

        def types
          @@types ||= {
            'all' => 'All files regardless of type',
            'scss' => 'SCSS files',
            'js' => 'Javascript files',
            'img' => 'Image files such as JPG, GIF, PNG and SVG',
            'font' => 'Font files such as WOFF, TTF, EOT and SVG'
          }
        end

      end
    end
  end
end
