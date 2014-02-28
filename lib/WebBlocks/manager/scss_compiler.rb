require 'compass'
require 'sass/plugin'
require 'sass-css-importer'

module WebBlocks
  module Manager
    class ScssCompiler

      def initialize framework, base_path

        @framework = framework
        @base_path = base_path

      end

      def execute!

        workspace_path = @base_path + '.blocks/workspace'
        cache_path = @base_path + '.blocks/cache/sass'
        options = {}

        Compass.add_configuration(
            {
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

      end

    end
  end
end