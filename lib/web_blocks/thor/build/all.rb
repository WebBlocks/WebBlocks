require 'tsort'
require 'web_blocks/thor/build'
require 'web_blocks/manager/parallel_builder'

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

        jobs = WebBlocks::Manager::ParallelBuilder.new self
        jobs.start :scss
        jobs.start :js
        jobs.save_when_done!

      end

    end
  end
end