require 'WebBlocks/support/parallel_jobs'
require 'WebBlocks/manager/js_builder'
require 'WebBlocks/manager/scss_builder'

module WebBlocks
  module Manager
    class BuilderJobs

      MAP = {
        :scss => { :scope_name => 'SCSS', :strategy => WebBlocks::Manager::ScssBuilder },
        :js => { :scope_name => 'JS', :strategy => WebBlocks::Manager::JsBuilder }
      }

      attr_reader :task
      attr_reader :log

      def initialize task, log
        @task = task
        @log = log
        @parallel_jobs = WebBlocks::Support::ParallelJobs.new
      end

      def start type
        @parallel_jobs.start do
          log.scope MAP[type][:scope_name] do |log|
            MAP[type][:strategy].new(task, log).execute!
          end
        end
      end

      def wait_for_complete!
        @parallel_jobs.wait_for_complete!
      end

    end
  end
end