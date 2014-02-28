require 'WebBlocks/thor/inspect'

module WebBlocks
  module Thor
    class Inspect

      list_desc = "Adjacency list of all files and dependencies"
      desc "dependency_list", list_desc
      long_desc list_desc
      method_option :type, :desc => "Any of: \"#{types.keys.join('", "')}\"; default \"all\"."
      def dependency_list
        type = self.class.type_get_class_from_string options.type
        framework.adjacency_list.each do |file, dependencies|
          next unless file.is_a? type
          say file.resolved_path.to_s
          dependencies.each do |dependency|
            say "  #{dependency.resolved_path.to_s}", :green
          end
        end
      end

    end
  end
end