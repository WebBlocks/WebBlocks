require 'tsort'
require 'WebBlocks/thor/link'
require 'WebBlocks/structure/scss_file'
require 'WebBlocks/manager/scss_linker_file'

module WebBlocks
  module Thor
    class Link

      description = "Construct linked construct of SCSS files based on dependencies"
      desc "scss", description
      long_desc description
      def scss
        begin
          #TODO: Fix this to be friendly to parallel processes and partial generation rather than building full file in one loop
          scss_linker_file = ::WebBlocks::Manager::ScssLinkerFile.new @base_path
          framework.get_file_load_order(::WebBlocks::Structure::ScssFile).each do |file|
            scss_linker_file.push file
          end
          scss_linker_file.save!
        rescue ::TSort::Cyclic => e
          say "Cycle detected with dependency load order", [:red, :bold]
          fail e, :red
        end
      end

    end
  end
end