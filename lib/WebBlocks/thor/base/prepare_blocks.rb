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

      class_option :include,
                   :type => :array,
                   :default => nil,
                   :desc => 'Paths to explicitly include'

      no_commands do

        def prepare_blocks!

          log.scope 'INIT' do |log|

            if !bower_manager.installed? or self.options.reload_bower
              install_bower_components! log
            elsif self.options.reload_registry
              clean_bower_registry! log
            end

            load_bower_registry! log
            load_blockfile! log
            include_own_routes! log
            include_routes_from_command_line! log if self.options.include

          end

        end

      end

      private

      def install_bower_components! log

        log.debug do
          bower_manager.clean_update!
          bower_manager.installed? ? 'Reloaded bower components and cleaning component registry' : 'Installed bower components'
        end

      end

      def clean_bower_registry! log

        log.debug do
          bower_manager.clean_registry_cache!
          'Cleaned bower component registry'
        end

      end

      def load_bower_registry! log

        log.scope 'Block' do |log|
          log.debug do
            task = self
            framework :path => @base_path do
              task.bower_manager.registry.components.each do |name, path|
                begin
                  log.debug name do
                    register :name => name, :path => path
                    "Loaded"
                  end
                rescue
                  log.warn("#{name}") { "Skipped -- Blockfile.rb does not exist" }
                end
              end
            end
            bower_manager.has_registry_cache? ? 'Loaded cached bower component registry' : 'Generated bower component registry'
          end
        end

      end

      def load_blockfile! log

        log.debug do

          root.instance_eval File.read blockfile_path
          "Loaded #{blockfile_path}"

        end

      end

      def include_own_routes! log

        own_name = bower_manager.registry.name
        if root.has_child? own_name
          root.children[own_name].set :required, true
        end

      end

      def include_routes_from_command_line! log

        route = []

        self.options.include.each do |segment|

          delimiter = segment[segment.length-1] == ','

          route.push delimiter ? segment[0,segment.length-1] : segment

          if delimiter
            root.include *route
            puts route.to_json
            route = []
          end

        end

        root.include *route if route.length > 0
        puts route.to_json

      end

    end
  end
end
