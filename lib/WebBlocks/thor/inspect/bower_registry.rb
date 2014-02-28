require 'WebBlocks/thor/inspect'

module WebBlocks
  module Thor
    class Inspect

      bower_registry_desc = "Registry of blocks as defined by bower.json"
      desc "bower_registry", bower_registry_desc
      long_desc bower_registry_desc
      def bower_registry
        bower_manager.get_registry.each do |name,path|
          say name, :bold
          say "  #{path}", :green
        end
      end

    end
  end
end