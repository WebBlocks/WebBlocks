require 'web_blocks/thor/inspect'

module WebBlocks
  module Thor
    class Inspect

      order_desc = "File order based on topological sort of dependency list"
      desc "dependency_order", order_desc
      long_desc order_desc
      method_option :type, :desc => "Any of: \"#{types.keys.join('", "')}\"; default \"all\"."

      def dependency_order

        prepare_blocks!

        type = self.class.type_get_class_from_string options.type

        root.get_file_load_order(type).each do |file|
          say "#{file.resolved_path.to_s}"
        end

      end

    end
  end
end