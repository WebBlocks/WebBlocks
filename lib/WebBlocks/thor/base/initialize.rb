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

      class_option :blockfile,
                   :type => :string,
                   :default => nil,
                   :desc => 'Location of Blockfile.rb'

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

        initialize_paths_from_resolved! unless initialize_paths_from_options!

        unless File.exists? blockfile_path
          log.fatal('INIT') { "Blockfile does not exist at #{blockfile_path}" }
          exit 1
        end

        unless File.exists? bowerfile_path
          log.fatal('INIT') { "bower.json does not exist at #{bowerfile_path}" }
          exit 1
        end

      end

      def initialize_paths_from_options!

        return false unless self.options.blockfile

        @blockfile_path = Pathname.new(Dir.pwd) + self.options.blockfile

        @base_path = @blockfile_path.parent
        @bowerfile_path = @base_path + 'bower.json'

      end

      def initialize_paths_from_resolved!


        path = Pathname.new(Dir.pwd) unless path

        if File.exists? path + 'Blockfile.rb'
          @base_path = path
          @blockfile_path = path + 'Blockfile.rb'
          @bowerfile_path = @base_path + 'bower.json'
          return true
        end

        if path.to_s == '/'
          log.fatal('INIT') { 'Blockfile could not be resolved' }
          exit 1
        end

        initialize_path! path.parent

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
