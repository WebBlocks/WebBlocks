require 'set'
require 'web_blocks/facade/base'
require 'web_blocks/facade/file_name_block'

module WebBlocks
  module Facade
    class DirectoryNameBlock < Base

      def handle name, attributes = {}, &block

        this = self

        attributes[:path] = name unless attributes.has_key? :path

        block_was_given = block_given?

        this.context.block name, attributes do |directory_block|

          directory_path = directory_block.resolved_path
          js_file_names = Set.new
          scss_file_names = Set.new

          Dir.entries(directory_path).each do |name|
            next if name == '.' or name == '..'
            path = "#{directory_path}/#{name}"
            if File.file? path
              segs = name.split('.')
              ext = segs.pop
              if ext == 'css'
                scss_file_names << "#{segs.join('.')}.css"
              elsif ext == 'js'
                js_file_names << "#{segs.join('.')}.js"
              elsif ext == 'scss'
                scss_file_names << segs.join('.').gsub(/^_/, '')
              end
            end
          end

          js_file_names.each { |name| directory_block.js_file name }
          scss_file_names.each { |name| directory_block.scss_file name }

          directory_block.instance_eval &block if block_was_given

        end

      end

    end
  end
end