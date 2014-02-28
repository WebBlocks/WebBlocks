require 'pathname'
require 'WebBlocks/manager/bower'
require 'WebBlocks/thor/base'

module WebBlocks
  module Thor
    class Base

      class_option :reload_bower,
                   :type => :boolean,
                   :default => false,
                   :desc => 'Reload Bower-managed blocks'

      class_option :reload_registry,
                   :type => :boolean,
                   :default => false,
                   :desc => 'Reload block registry rather than using cache'

      no_commands do

        def prepare!

          if !bower_manager.installed? or self.options.reload_bower
            install_bower_components!
          elsif self.options.reload_registry
            clean_bower_registry!
          end

          load_bower_registry!
          load_blocksfile!

        end

      end

      private

      def install_bower_components!

        log :debug, bower_manager.installed? ? 'Reloading bower components and cleaning component registry' : 'Installing bower components'
        bower_manager.clean_update!

      end

      def clean_bower_registry!

        log :debug, 'Cleaning bower component registry'
        bower_manager.clean_registry_cache!

      end

      def load_bower_registry!
        log :debug, bower_manager.has_registry_cache? ? 'Loading cached bower component registry' : 'Generating bower component registry'
        task = self
        framework :path => @base_path do
          task.bower_manager.get_registry.each do |name, path|
            begin
              register :name => name, :path => path
            rescue
              task.log :warn, "Initialization skipping block #{name} because no block file exists"
            end
          end
        end
      end

      def load_blocksfile!
        log :debug, "Loading #{@blocksfile_path}..."
        require @blocksfile_path
      end

    end
  end
end
