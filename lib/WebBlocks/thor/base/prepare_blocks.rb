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

        def prepare_blocks!

          log.scope 'INIT' do |log|

            if !bower_manager.installed? or self.options.reload_bower
              install_bower_components! log
            elsif self.options.reload_registry
              clean_bower_registry! log
            end

            load_bower_registry! log
            load_blockfile! log

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
              task.bower_manager.get_registry.each do |name, path|
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
          framework.instance_eval File.read blockfile_path
          "Loaded #{blockfile_path}"
        end

      end

    end
  end
end
