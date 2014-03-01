require 'compass'
require 'sass/plugin'
require 'sass-css-importer'

module WebBlocks
  module Strategy
    module Compile
      class Scss

        attr_reader :log
        attr_reader :io
        attr_reader :workspace_path
        attr_reader :cache_path

        def initialize task, log

          @task = task
          @log = log.scope 'Compile'

          @workspace_path = @task.base_path + '.blocks/workspace'
          @cache_path = @task.base_path + '.blocks/cache/sass'

        end

        def execute!

          log.info { "Starting" }

          output = StringIO.new

          with_compass_io output do
            configure_compass!
            compile_files!
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

        def compile_files!

          compile_file workspace_path + 'scss/blocks.scss', workspace_path + 'css/blocks.css'

        end

        def compile_file src, dst

          FileUtils.mkdir_p dst.parent
          Compass.compiler.compile src.to_s, dst.to_s

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