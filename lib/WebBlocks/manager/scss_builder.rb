require 'WebBlocks/manager/scss_linker'
require 'WebBlocks/manager/scss_compiler'

module WebBlocks
  module Manager
    class ScssBuilder

      attr_reader :log
      attr_reader :task

      def initialize task, log

        @task = task
        @log = log.scope 'Builder'

      end

      def execute!

        log.info { "Starting" }

        WebBlocks::Manager::ScssLinker.new(task, log).execute!
        WebBlocks::Manager::ScssCompiler.new(task, log).execute!

        log.info { "Finished" }

      end

    end
  end
end