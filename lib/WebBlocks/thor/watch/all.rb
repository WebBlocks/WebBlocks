require 'tsort'
require 'pathname'
require 'fork'
require 'fssm'
require 'WebBlocks/thor/watch'
require 'WebBlocks/manager/js_linker'
require 'WebBlocks/manager/scss_linker'
require 'WebBlocks/manager/scss_compiler'

module WebBlocks
  module Thor
    class Watch

      description = "Watch and rebuild all assets"
      desc "all", description
      long_desc description

      def all

        # TODO: refactor this file so it's not a run-on routine

        begin

          prepare_blocks!

          task = self

          triggers = framework.adjacency_list.keys.map(){|f| f.resolved_path.to_s }
          triggers << base_path + 'Blocksfile.rb'
          triggers << base_path + '.blocks/cache/bower/registry.yaml'
          triggers << base_path + 'bower_components/*/Blockfile.rb'

          handler = Proc.new do |base, relative|

            changed_file = Pathname.new(base) + relative
            relink_needed = changed_file.to_s.match(/Blocks+file.rb$/)

            @log.info("Watch"){ "Detected change to #{changed_file}" }

            if relink_needed
              framework.remove_all_children
              prepare_blocks!
            end

            # TODO: refactor thread management into a concurrency manager

            scss = Fork.execute :return do
              @log.thread_name = "SCSS"
              WebBlocks::Manager::ScssLinker.new(task).execute!
              WebBlocks::Manager::ScssCompiler.new(task).execute!
              true
            end

            js = Fork.execute :return do
              @log.thread_name = "JS"
              WebBlocks::Manager::JsLinker.new(task).execute!
              true
            end

            scss.return_value
            js.return_value

          end

          monitor = FSSM::Monitor.new
          monitor.path @base_path do
            glob triggers
            update &handler
            delete &handler
            create &handler
          end
          monitor.run


        rescue ::TSort::Cyclic => e

          say "Cycle detected with dependency load order", [:red, :bold]
          fail e, :red

        end

      end

    end
  end
end