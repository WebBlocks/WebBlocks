require 'set'
require 'web_blocks/facade/base'
require 'web_blocks/facade/file_name_block'

module WebBlocks
  module Facade
    class RecursiveFileNamesBlock < Base

      def handle name, attributes = {}, &block

        this = self

        attributes[:path] = name unless attributes.has_key? :path

        block_was_given = block_given?

        this.context.block name, attributes do |directory_block|

          directory_path = directory_block.resolved_path
          directory_facade = ::WebBlocks::Facade::RecursiveFileNamesBlock.new(directory_block)
          file_facade = ::WebBlocks::Facade::FileNameBlock.new(directory_block)
          file_names = Set.new

          Dir.entries(directory_path).each do |name|
            next if name == '.' or name == '..'
            path = "#{directory_path}/#{name}"
            if File.directory? path
              directory_facade.handle name, path: name
            else
              segs = name.split('.')
              ext = segs.pop
              if ext == 'css' or ext == 'js'
                file_names << segs.join('.')
              elsif ext == 'scss'
                file_names << segs.join('.').gsub(/^_/, '')
              end
            end
          end

          file_names.each { |name| file_facade.handle name }

          directory_block.instance_eval &block if block_was_given

        end
      end

    end
  end
end