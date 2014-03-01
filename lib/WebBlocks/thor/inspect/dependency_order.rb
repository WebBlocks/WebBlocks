require 'tsort'
require 'WebBlocks/thor/inspect'

module WebBlocks
  module Thor
    class Inspect

      order_desc = "File order based on topological sort of dependency list"
      desc "dependency_order", order_desc
      long_desc order_desc
      method_option :type, :desc => "Any of: \"#{types.keys.join('", "')}\"; default \"all\"."
      def dependency_order
        type = self.class.type_get_class_from_string options.type
        begin
          with_blocks do
            framework.get_file_load_order(type).each do |file|
              say "#{file.resolved_path.to_s}"
            end
          end
        rescue ::TSort::Cyclic => e
          log.fatal "Cycle detected with dependency load order"
          fail e, :red
        end
      end

    end
  end
end