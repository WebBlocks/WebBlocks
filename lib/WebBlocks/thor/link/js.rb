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

          prepare_blocks!
          ::WebBlocks::Manager::JsLinker.new(self).execute!

        rescue ::TSort::Cyclic => e

          log.fatal "Cycle detected with dependency load order"
          fail e, :red

        end
      end

    end
  end
end