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

          yield if block_given?

        end

        def save!

          yield task.base_path + task.root.get(:build_dir) if block_given?

        end

      end
    end
  end
end