require 'compass'
require 'sass/plugin'
require 'sass-css-importer'

module WebBlocks
  module Strategy
    module Compile
      class Scss

        attr_reader :task
        attr_reader :log
        attr_reader :workspace_path
        attr_reader :cache_path
        attr_reader :product_path
        attr_reader :source_path

        def initialize task

          @task = task
          @log = task.log.scope 'SCSS - Compile'
          @workspace_path = task.base_path + '.blocks/workspace'
          @cache_path = task.base_path + '.blocks/cache/sass'
          @source_path = @workspace_path + 'scss/blocks.scss'
          @product_path = @workspace_path + 'css/blocks.css'

        end

        def execute!

          log.info { "Starting" }

          output = StringIO.new

          with_compass_io output do
            configure_compass!
            compass_compile!
          end

          output.rewind
          output.each_line { |line| log.debug("Compass"){ line.to_s.gsub(/\n/,'') } }

          log.info { "Finished" }

        end

        def configure_compass!

          Compass.add_configuration({
              :project_path => workspace_path,
              :sass_path => 'scss',
              :css_path => 'css',
              :cache_path => cache_path
            },
            'blocks'
          )

        end

        def compass_compile!

          FileUtils.mkdir_p product_path.parent
          Compass.compiler.compile source_path.to_s, product_path.to_s

        end

        def with_compass_io io

          alias_mapping = {
            :color => Proc.new { |c| "" },
            :log => Proc.new { |msg| io.puts msg }
          }

          alias_mapping.each do |method, proc|
            Compass::Logger.send :alias_method, "___#{method}", method
            Compass::Logger.send :define_method, method, &proc
          end

          yield

          alias_mapping.keys.each do |method|
            Compass::Logger.send :alias_method, method, "___#{method}"
            Compass::Logger.send :remove_method, "___#{method}"
          end

        end

      end
    end
  end
end