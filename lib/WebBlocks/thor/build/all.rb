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

        begin

          prepare_blocks!

          jobs = WebBlocks::Manager::ParallelBuilder.new self, log
          jobs.start :scss
          jobs.start :js
          jobs.wait_for_complete!

        rescue ::TSort::Cyclic => e

          say "Cycle detected with dependency load order", [:red, :bold]
          fail e, :red

        end

      end

    end
  end
end