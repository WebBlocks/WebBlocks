require 'pathname'
require 'WebBlocks/support/thread_logger'
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

        @log = ::WebBlocks::Support::ThreadLogger.new ::Logger.new(STDOUT)
        @log.thread_name = 'MAIN'

      end

    end
  end
end
