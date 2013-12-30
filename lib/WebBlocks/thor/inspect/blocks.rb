module WebBlocks
  module Thor
    class Inspect

      blocks_desc = 'List of registered blocks, optionally with attributes and filtered to a route'
      desc "blocks", blocks_desc
      long_desc blocks_desc
      method_option :route, :type => :array, :default => [], :desc => 'Route to block to print'
      method_option :attributes, :type => :boolean, :default => false, :desc => 'Show block attributes'
      def blocks
        print_block = Proc.new { |node, depth = 0|
          spaces = Array.new(depth + 1).join('  ')
          say "#{spaces}#{node.name} (#{node.class.name.split('::')[-1]})", (node.respond_to?(:children) ? :bold : [])
          if options.attributes
            node.attributes.each do |key, value|
              if value.is_a?(::Array) or value.is_a?(::Hash)
                say "#{spaces}  :#{key} = #{value}", :green if value.size > 0
              elsif value.is_a?(::String)
                say "#{spaces}  :#{key} = \"#{value}\"", :green
              elsif value.is_a?(::TrueClass)
                say "#{spaces}  :#{key} = true", :green
              elsif value.is_a?(::FalseClass)
                say "#{spaces}  :#{key} = false", :red
              end
            end
          end
          if node.respond_to? :children
            node.children.each do |_, child|
              print_block.call child, depth + 1
            end
          end
        }
        print_block.call(framework.block_from_route options.route)
      end

    end
  end
end