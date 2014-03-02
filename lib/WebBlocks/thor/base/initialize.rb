require 'pathname'
require 'logger'
require 'WebBlocks/support/scoped_logger'
require 'WebBlocks/manager/bower'
require 'WebBlocks/thor/base'

module WebBlocks
  module Thor
    class Base

      attr_reader :base_path
      attr_reader :bowerfile_path
      attr_reader :blockfile_path
      attr_reader :bower_manager
      attr_reader :log
      attr_reader :root

      class_option :base_path,
                   :type => :string,
                   :default => nil,
                   :desc => 'Path to workspace'

      class_option :blockfile_path,
                   :type => :string,
                   :default => nil,
                   :desc => 'Path to workspace'

      def initialize args = [], options = {}, config = {}

        super args, options, config

        initialize_log!
        initialize_paths!
        initialize_bower_manager!
        initialize_root!

      end

      private

      def initialize_log!
        base = ::Logger.new STDOUT
        base.level = ::Logger::DEBUG
        base.datetime_format = '%Y-%m-%d %H:%M:%S'
        @log = ::WebBlocks::Support::ScopedLogger.new_without_scope base
      end

      def initialize_paths!

        initialize_base_path_from_resolved! unless initialize_base_path_from_options!
        initialize_bowerfile_path!
        initialize_blockfile_path!

      end

      def initialize_base_path_from_options!

        if self.options.base_path
          @base_path = Pathname.new(Dir.pwd) + self.options.base_path
          true
        else
          false
        end

      end

      def initialize_base_path_from_resolved! path = nil

        path = Pathname.new(Dir.pwd) unless path

        if File.exists? path + 'bower.json'
          @base_path = path
          return true
        end

        if path.to_s == '/'
          log.fatal('INIT') { 'Workspace could not be resolved' }
          exit 1
        end

        initialize_base_path_from_resolved! path.parent

      end

      def initialize_bowerfile_path!

        @bowerfile_path = base_path + 'bower.json'

        unless File.exists? @bowerfile_path
          log.fatal('INIT') { "bower.json does not exist at #{bowerfile_path}" }
          exit 1
        end

      end

      def initialize_blockfile_path!

        if self.options.blockfile_path
          @blockfile_path = Pathname.new(Dir.pwd) + self.options.blockfile_path
        else
          @blockfile_path = base_path + 'Blockfile.rb'
        end

        unless File.exists? blockfile_path
          log.fatal('INIT') { "Blockfile does not exist at #{blockfile_path}" }
          exit 1
        end

      end

      def initialize_bower_manager!

        @bower_manager = ::WebBlocks::Manager::Bower.new @base_path

      end

      def initialize_root!

        @root = framework

      end

    end
  end
end
