require 'web_blocks/facade/base'

module WebBlocks
  module Facade
    class RegistrationScope < Base

      def initialize context
        super context
        @@registration_scope = nil unless defined? @@registration_scope
      end

      def handle command = nil, data = {}, &block
        case command
          when :set
            @@registration_scope = data
          when :unset
            @@registration_scope = nil
        end
        @@registration_scope
      end

    end
  end
end

