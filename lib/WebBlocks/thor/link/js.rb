require 'tsort'
require 'WebBlocks/thor/link'
require 'WebBlocks/manager/js_linker'

module WebBlocks
  module Thor
    class Link

      description = "Construct linked construct of JS files based on dependencies"
      desc "js", description
      long_desc description
      def js
        begin
          ::WebBlocks::Manager::JsLinker.new(framework, @base_path).execute!
        rescue ::TSort::Cyclic => e
          say "Cycle detected with dependency load order", [:red, :bold]
          fail e, :red
        end
      end

    end
  end
end