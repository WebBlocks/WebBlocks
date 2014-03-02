module WebBlocks
  module Strategy
    module Link
      class Base

        attr_reader :task
        attr_reader :log
        attr_reader :linker_file
        attr_accessor :files_to_link

        def initialize task

          @task = task
          @log = task.log.scope 'Link'
          @linker_file = make_linker_file
          @files_to_link = compute_files_to_link

        end

        def execute!

          log.info { "Starting" }

          files_to_link.each do |file|
            log.debug do
              linker_file.push file
              "Linked #{file.resolved_path}"
            end
          end

          log.debug do
            linker_file.save!
            "Saved #{linker_file.path}"
          end

          log.info { "Finished" }

        end

        def make_linker_file
          raise NoMethodError, "undefined method `make_linker_file!' for #{self}"
        end

        def compute_files_to_link
          []
        end

      end
    end
  end
end