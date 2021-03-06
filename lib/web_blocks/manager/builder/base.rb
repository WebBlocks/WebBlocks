module WebBlocks
  module Manager
    module Builder
      class Base

        attr_reader :log
        attr_reader :task

        def initialize task

          @task = task
          @log = task.log.scope 'BUILD'

        end

        def execute!

          yield if block_given?

        end

        def save!

          yield task.base_path + task.root.get(:build_path) if block_given?

        end

      end
    end
  end
end