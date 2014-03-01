require 'fork'

module WebBlocks
  module Support
    class ParallelJobs
      def initialize
        @running = []
      end
      def start &block
        fork = Fork.execute :return do
          yield
          true
        end
        @running << fork
      end
      def wait_for_complete!
        @running.each { |p| p.return_value }
        @running = []
      end
    end
  end
end