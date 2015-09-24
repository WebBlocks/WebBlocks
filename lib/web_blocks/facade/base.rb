require 'web_blocks/facade/base'

module WebBlocks
  module Facade
    class Base

      attr_reader :context

      def initialize context
        @context = context
      end

    end
  end
end

