module WebBlocks
  module Framework

    def framework options = {}, &block

      # Lazy-load to avoid cyclical require loop with 'WebBlocks/structure/framework'
      require 'WebBlocks/structure/framework'
      @@framework ||= ::WebBlocks::Structure::Framework.new 'framework'

      # Set options, if any were passed
      options.each { |name, value| @@framework.set name, value }

      # Evaluate block in context of WebBlocks::Structure::Framework singleton represented by this method
      @@framework.instance_eval(&block) if block_given?
      @@framework

    end

  end
end