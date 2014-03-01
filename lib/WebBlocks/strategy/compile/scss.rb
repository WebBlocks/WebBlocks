require 'compass'
require 'sass/plugin'
require 'sass-css-importer'

module WebBlocks
  module Strategy
    module Compile
      class Scss

        attr_reader :log

        def initialize task, log

          @task = task
          @log = log.scope 'Compile'

        end

        def execute!

          log.info { "Starting" }

          workspace_path = @task.base_path + '.blocks/workspace'
          cache_path = @task.base_path + '.blocks/cache/sass'
          options = {}

          output = StringIO.new

          Compass::Logger.send(:define_method, :color) { |c| "" }
          Compass::Logger.send(:define_method, :log) { |msg| output.puts msg }

          Compass.add_configuration({
              :project_path => workspace_path,
              :sass_path => 'scss',
              :css_path => 'css',
              :cache_path => cache_path
            },
            'blocks'
          )

          from = (workspace_path + 'scss/blocks.scss')
          to = (workspace_path + 'css/blocks.css')

          FileUtils.mkdir_p to.parent
          Compass.compiler.compile from.to_s, to.to_s

          output.rewind
          output.each_line { |line| log.debug("Compass"){ line.to_s.gsub(/\n/,'') } }

          log.info { "Finished" }

        end

      end
    end
  end
end