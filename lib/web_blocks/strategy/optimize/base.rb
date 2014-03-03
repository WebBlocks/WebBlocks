module WebBlocks
  module Strategy
    module Optimize
      class Base

        attr_reader :task
        attr_reader :log
        attr_reader :product_path
        attr_reader :source_path

        def initialize task

          @task = task
          @log = task.log.scope 'Optimize'
          @product_path = false
          @source_path = false

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