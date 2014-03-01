require 'WebBlocks/manager/js_linker'

module WebBlocks
  module Manager
    class JsBuilder

      attr_reader :log
      attr_reader :task

      def initialize task, log

        @task = task
        @log = log.scope 'Builder'

      end

      def execute!

        log.info { "Starting" }

        WebBlocks::Manager::JsLinker.new(task, log).execute!

        log.info { "Finished" }

      end

    end
  end
end