require 'fork'

module WebBlocks
  module Support
    class ParallelJobs
      def initialize
        @running = []
      end
      def start &block
        fork = Fork.execute :return, :exceptions do
          yield
          true
        end
        @running << fork
      end
      def wait_for_complete!
        begin
          @running.each { |p| p.return_value }
        ensure
          @running.each { |p| p.kill if p.alive? }
          @running = []
        end
      end
    end
  end
end