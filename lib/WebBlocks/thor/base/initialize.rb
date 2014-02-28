require 'pathname'
require 'WebBlocks/manager/bower'
require 'WebBlocks/thor/base'

module WebBlocks
  module Thor
    class Base

      attr_accessor :base_path
      attr_accessor :bower_manager

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

      end

    end
  end
end
