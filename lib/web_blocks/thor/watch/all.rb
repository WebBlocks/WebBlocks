require 'pathname'
require 'fssm'
require 'web_blocks/thor/watch'
require 'web_blocks/manager/parallel_builder'

module WebBlocks
  module Thor
    class Watch

      description = "Watch and rebuild all assets"
      desc "all", description
      long_desc description
      method_option :build, :type => :boolean, :default => false, :desc => 'Build on starting watch'

      def all

        # TODO: refactor this file so it's not a run-on routine

        prepare_blocks!

        task = self

        triggers = root.adjacency_list.keys.map(){|f| f.resolved_path.to_s }
        triggers << base_path + 'Blockfile.rb'
        triggers << base_path + '.blocks/cache/bower/registry.yaml'
        triggers << base_path + 'bower_components/*/Blockfile.rb'

        handler = Proc.new do |base, relative|

          changed_file = Pathname.new(base) + relative
          relink_needed = changed_file.to_s.match(/Blockfile.rb$/)

          log.info("Watch"){ "Detected change to #{changed_file}" }

          if relink_needed
            root.remove_all_children
            initialize_root!
            prepare_blocks!
          end

          begin

            jobs = WebBlocks::Manager::ParallelBuilder.new task
            jobs.start :scss
            jobs.start :js
            jobs.save_when_done!

          rescue ::TSort::Cyclic => e

            log.error("Watch"){ "Build failed -- Cyclical dependencies detected" }

          rescue ::Sass::SyntaxError => e

            log.error("Watch"){ "Build failed -- Sass syntax error: #{e}" }

          rescue => e

            log.error("Watch"){ "Build failed -- #{e.class.name}: #{e}" }

          end

        end

        if options.build
          prepare_blocks!
          jobs = WebBlocks::Manager::ParallelBuilder.new self
          jobs.start :scss
          jobs.start :js
          jobs.save_when_done!
        end

        monitor = FSSM::Monitor.new
        monitor.path @base_path do
          glob triggers
          update &handler
          delete &handler
          create &handler
        end
        monitor.run

      end

    end
  end
end