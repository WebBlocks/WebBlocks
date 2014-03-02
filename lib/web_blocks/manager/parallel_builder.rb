require 'web_blocks/support/parallel_jobs'
require 'web_blocks/manager/builder/js'
require 'web_blocks/manager/builder/scss'

module WebBlocks
  module Manager
    class ParallelBuilder

      MAP = {
        :scss => {
          :scope_name => 'SCSS',
          :strategy => WebBlocks::Manager::Builder::Scss
        },
        :js => { :scope_name => 'JS', :strategy => WebBlocks::Manager::Builder::Js }
      }

      attr_reader :task
      attr_reader :log

      def initialize task

        @task = task
        @log = task.log
        @parallel_jobs = WebBlocks::Support::ParallelJobs.new
        @started_strategies = []

      end

      def start type

        strategy = MAP[type][:strategy].new(task)

        @parallel_jobs.start do
          log.scope MAP[type][:scope_name] do |log|
            strategy.execute!
          end
        end

        @started_strategies << strategy

      end

      def save_when_done!

        @parallel_jobs.wait_for_complete!
        @started_strategies.each { |strategy| strategy.save! }

      end

    end
  end
end