require 'web_blocks/facade/external_component_block'
require 'web_blocks/facade/registration_scope'
require 'web_blocks/structure/block'
require 'web_blocks/structure/raw_file'
require 'web_blocks/support/tsort/hash'

module WebBlocks
  module Structure
    class Framework < Block

      set :required, true

      # FRAMEWORK DSL

      register_facade :external_component_block, WebBlocks::Facade::ExternalComponentBlock
      register_facade :registration_scope, WebBlocks::Facade::RegistrationScope

      def after name, &block
        for_notification "after_#{name}".to_sym, &block
      end

      def before name, &block
        for_notification "before_#{name}".to_sym, &block
      end

      def include *args
        block = self
        args.each do |name|
          block = block.block(name)
          block.set :required, true
        end
        nodes = block.children.values
        while nodes.length > 0
          node = nodes.pop
          node.set :required, true
          if node.respond_to? :children
            node.children.values.each { |node_child| nodes << node_child }
          end
        end
      end

      # FRAMEWORK METHODS

      def register hash
        name = hash[:name]
        path = hash[:path]
        resolved_block_path = resolved_path + path
        blockfile_path =  resolved_block_path + "Blockfile.rb"
        raise "Undefined blockfile for #{path}" unless File.exists?(blockfile_path)
        in_registration_scope resolved_block_path do
          instance_eval File.read(blockfile_path)
        end
      end

      def in_registration_scope resolved_block_path, &block
        isolated_facade_registration_scope do
          with_base_path(resolved_block_path) do
            registration_scope :set, path: resolved_block_path
            instance_eval &block
            registration_scope :unset
          end
        end
      end

      def for_notification name, &block
        @notification = {} unless defined? @notification
        @notification[name] = [] unless @notification.has_key?(name)
        @notification[name].push block
      end

      def notify name, opts = {}
        if defined?(@notification) and @notification.has_key?(name)
          @notification[name].each do |proc|
            instance_exec opts, &proc
          end
        end
      end

      def block_from_route route
        block = self
        route.each { |name| block = block.block(name) }
        block
      end

      def adjacency_list

        file_dependencies = {}

        files = required_files
        while files.length > 0
          file = files.pop
          file_dependencies[file] = []
          file.resolve_dependencies.each do |dependency_route|
            block_from_route(dependency_route).files.each do |dependency_file|
              files << dependency_file unless file_dependencies.has_key?(dependency_file)
              file_dependencies[file] << dependency_file
            end
          end
        end

        file_dependencies.each do |file, dependencies|
          file.resolve_loose_dependencies.each do |dependency_route|
            block_from_route(dependency_route).files.each do |dependency_file|
              file_dependencies[file] << dependency_file if file_dependencies.has_key?(dependency_file)
            end
          end
        end

      end

      def get_file_load_order type = RawFile
        ::WebBlocks::Support::TSort::Hash.try_convert(adjacency_list).tsort.keep_if(){ |file| file.is_a? type }
      end

    end
  end
end
