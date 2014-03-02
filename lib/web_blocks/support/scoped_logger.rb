require 'logger'
require 'delegate'

module WebBlocks
  module Support
    class ScopedLogger < ::SimpleDelegator

      class << self
        def new_without_scope logdev, shift_age = 0, shift_size = 1048576
          self.new nil, logdev, shift_age, shift_size
        end
      end

      attr_accessor :scopename

      def initialize scopename, logdev, shift_age = 0, shift_size = 1048576
        if logdev.is_a? ::Logger or logdev.is_a? ::WebBlocks::Support::ScopedLogger
          super logdev
        else
          super ::Logger.new logdev, shift_age, shift_size
        end
        @scopename = scopename
      end

      def scope name = nil, &block
        scoped_logger = self.class.new scopename ? "#{scopename} - #{name}" : name, __getobj__
        yield scoped_logger if block_given?
        scoped_logger
      end

      def scoped_progname progname = nil
        if scopename
          progname ? "#{scopename} - #{progname}" : scopename
        else
          progname ? progname : nil
        end
      end

      def add severity, message = nil, progname = nil, &block
        __getobj__.add(severity, message, scoped_progname(progname), &block)
      end

      [:debug, :error, :fatal, :info, :unknown, :warn].each do |method|
        define_method(method) { |progname = nil, &block| __getobj__.send(method, scoped_progname(progname), &block) }
      end

    end
  end
end