require 'fileutils'
require 'yaml'
require 'ruby-bower'

module WebBlocks
  module Manager
    class Bower

      attr_reader :base_path
      attr_reader :cache_path
      attr_reader :components_path
      attr_reader :registry_cache_path

      def initialize base_path
        @base_path = base_path
        @cache_path = base_path + '.blocks/cache/bower'
        @registry_cache_path = @cache_path + 'registry.yaml'
        @components_path = base_path + 'bower_components'
      end

      def installed?
        File.exists? @components_path
      end

      def clean_registry_cache!
        FileUtils.rm_f @cache_path + 'registry.yaml'
      end

      def clean_components_cache!
        ::Bower.context.call "bower.commands.cache.clean"
      end

      def prune_components!
        ::Bower.context.call "bower.commands.prune"
      end

      def update!
        ::Bower.context.call "bower.commands.update"
      end

      def clean_update!
        clean_registry_cache!
        clean_components_cache!
        prune_components!
        update!
      end

      def compute_registry
        registry = {}
        dependencies = ::Bower.context.call("bower.commands.list", :sources => true)['dependencies'].values
        while dependencies.length > 0
          dependency = dependencies.pop
          registry[dependency['pkgMeta']['name']] = dependency['canonicalDir']
          dependency['dependencies'].values.each do |dependency|
            dependencies << dependency unless registry.has_key? dependency['pkgMeta']['name']
          end
        end
        registry
      end

      def has_registry_cache?
        File.exists? registry_cache_path
      end

      def get_registry_cache
        YAML::load_file registry_cache_path
      end

      def save_registry_cache registry
        FileUtils.mkdir_p cache_path
        File.open(registry_cache_path, 'w') {|f| f.write registry.to_yaml }
      end

      def get_registry
        if has_registry_cache?
          registry = get_registry_cache
        else
          registry = compute_registry
          save_registry_cache registry
        end
        registry
      end

    end
  end
end