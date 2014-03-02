module WebBlocks
  module Manager
    module Builder
      class Base

        attr_reader :log
        attr_reader :task

        def initialize task

          @task = task
          @log = task.log.scope 'Builder'

        end

        def execute!

          log.info { "Starting" }

          yield if block_given?

          log.info { "Finished" }

        end

      end
    end
  end
end