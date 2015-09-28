require 'web_blocks/facade/base'

module WebBlocks
  module Facade
    class FileNameBlock < Base

      def handle name, attributes = {}, &block

        this = self

        block_was_given = block_given?

        this.context.block name, attributes do |block_entity|

          if File.exists? "#{block_entity.resolved_path}/#{name}.css"
            block_entity.scss_file "#{name}.css"
          end

          if File.exists? "#{block_entity.resolved_path}/#{name}.js"
            block_entity.js_file "#{name}.js"
          end

          if File.exists?("#{block_entity.resolved_path}/#{name}.scss") or File.exists?("#{block_entity.resolved_path}/_#{name}.scss")
            block_entity.scss_file name
          end

          block_entity.instance_eval &block if block_was_given

        end

      end

    end
  end
end