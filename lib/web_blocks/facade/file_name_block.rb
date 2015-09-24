require 'web_blocks/facade/base'

module WebBlocks
  module Facade
    class FileNameBlock < Base

      attr_reader :types

      def initialize context
        super context
        @types = {
            'css' => :scss_file,
            'js' => :js_file,
            'scss' => :scss_file
        }
      end

      def handle name, attributes = {}, &block

        this = self

        block_was_given = block_given?

        this.context.block name, attributes do |block_entity|
          this.types.each do |extension, method_name|
            block_entity.send(method_name, "#{name}.#{extension}") if File.exists?("#{block_entity.resolved_path}/#{name}.#{extension}")
          end
          block_entity.instance_eval &block if block_was_given
        end

      end

    end
  end
end