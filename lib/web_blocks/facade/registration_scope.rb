require 'web_blocks/facade/base'

module WebBlocks
  module Facade
    class RegistrationScope < Base

      def initialize context
        super context
        @@component = nil unless defined? @@component
      end

      def handle command = nil, data = {}, &block
        case command
          when :set
            @@component = data
          when :unset
            @@component = nil
        end
        @@component
      end

    end
  end
end

