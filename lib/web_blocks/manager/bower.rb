require 'fileutils'
require 'ostruct'
require 'json'
require 'ruby-bower'

module WebBlocks
  module Manager
    class Bower

      attr_reader :base_path
      attr_reader :bowerfile_path
      attr_reader :cache_path
      attr_reader :components_path
      attr_reader :registry_cache_path

      def initialize base_path
        @base_path = base_path
        @bowerfile_path = base_path + 'bower.json'
        @cache_path = base_path + '.blocks/cache/bower'
        @registry_cache_path = @cache_path + 'registry.json'
        @components_path = base_path + 'bower_components'
        @registry = nil
      end

      def installed?
        File.exists? @components_path
      end

      def clean_registry_cache!
        FileUtils.rm_f registry_cache_path
      end

      def clean_components_cache!
        ::Bower.context.call "bower.commands.cache.clean"
      end

      def prune_components!
        ::Bower.context.call "bower.commands.prune"
      end

      def clean_components!
        FileUtils.rm_rf @components_path
      end

      def install!
        ::Bower.context.call "bower.commands.install"
      end

      def clean_install!
        clean_registry_cache!
        clean_components_cache!
        prune_components!
        install!
      end

      def compute_registry
        {
          'name' => compute_registry_name,
          'components' => compute_registry_components
        }
      end

      def compute_registry_name
        definition = JSON.parse File.read bowerfile_path
        definition['name']
      end

      def compute_registry_components
        components = {}
        dependencies = ::Bower.context.call("bower.commands.list", :sources => true)['dependencies'].values
        while dependencies.length > 0
          dependency = dependencies.pop
          components[dependency['pkgMeta']['name']] = dependency['canonicalDir']
          dependency['dependencies'].values.each do |dependency|
            dependencies << dependency unless components.has_key? dependency['pkgMeta']['name']
          end
        end
        components
      end

      def has_registry_cache?
        File.exists? registry_cache_path
      end

      def get_registry_cache
        JSON.parse File.read registry_cache_path
      end

      def save_registry_cache registry
        FileUtils.mkdir_p cache_path
        File.open(registry_cache_path, 'w') {|f| f.write registry.to_json }
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

      def registry
        @registry ||= OpenStruct.new get_registry
      end

    end
  end
end