require 'pathname'
require 'WebBlocks/manager/bower'
require 'WebBlocks/thor/base'

module WebBlocks
  module Thor
    class Base

      class_option :reload_bower, :type => :boolean, :default => false, :desc => 'Reload Bower-managed blocks'
      class_option :reload_registry, :type => :boolean, :default => false, :desc => 'Reload block registry rather than using cache'

      def initialize args = [], options = {}, config = {}

        super args, options, config

        log :debug, "Starting initialization", :bold

        @base_path = Pathname.new(Dir.pwd)
        until @blocksfile_path
          blocksfile_path = @base_path + 'Blocksfile.rb'
          if File.exists? blocksfile_path
            @blocksfile_path = blocksfile_path
          elsif @base_path.to_s != '/'
            @base_path = @base_path.parent
          else
            log :fail, 'Could not find Blocksfile.rb'
            exit
          end
        end

        bower_manager = ::WebBlocks::Manager::Bower.new @base_path

        if !bower_manager.installed? or self.options.reload_bower
          log :debug, bower_manager.installed? ? 'Reloading bower components and registry...' : 'Installing bower components...'
          bower_manager.clean_update!
        elsif self.options.reload_registry
          log :debug, 'Reloading bower components registry...'
          bower_manager.clean_registry_cache!
        end

        log :debug, bower_manager.has_registry_cache? ? 'Loading cached bower component registry...' : 'Generating bower component registry...'
        @bower_registry = bower_registry = bower_manager.get_registry
        framework :path => @base_path do
          bower_registry.each { |name, path| register :name => name, :path => path }
        end

        log :debug, "Loading #{@blocksfile_path}..."
        require @blocksfile_path

        log :debug, "Initialization complete", :bold

      end

    end
  end
end
