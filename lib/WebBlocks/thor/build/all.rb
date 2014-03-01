require 'tsort'
require 'WebBlocks/thor/link'
require 'WebBlocks/manager/parallel_builder'

class Fork

end

module WebBlocks
  module Thor
    class Build

      description = "Build all assets"
      desc "all", description
      long_desc description

      def all

        prepare_blocks!

        jobs = WebBlocks::Manager::ParallelBuilder.new self, log
        jobs.start :scss
        jobs.start :js
        jobs.wait_for_complete!

      end

    end
  end
end