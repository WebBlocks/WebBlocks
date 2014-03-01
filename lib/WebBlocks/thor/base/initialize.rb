require 'pathname'
require 'logger'
require 'WebBlocks/support/scoped_logger'
require 'WebBlocks/manager/bower'
require 'WebBlocks/thor/base'

module WebBlocks
  module Thor
    class Base

      attr_accessor :base_path
      attr_accessor :bower_manager
      attr_accessor :log

      def initialize args = [], options = {}, config = {}

        super args, options, config

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

        @bower_manager = ::WebBlocks::Manager::Bower.new @base_path

        base = ::Logger.new STDOUT
        base.level = ::Logger::DEBUG
        base.datetime_format = '%Y-%m-%d %H:%M:%S'
        @log = ::WebBlocks::Support::ScopedLogger.new_without_scope base

      end

    end
  end
end
