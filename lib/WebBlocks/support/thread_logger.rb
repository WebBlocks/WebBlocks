require 'logger'
require 'delegate'

module WebBlocks
  module Support
    class ThreadLogger < ::SimpleDelegator

      def initialize *args
        super *args
        @thread_names = {}
      end

      def thread_name= name
        @thread_names[Thread.current] = name
      end

      def add severity, message = nil, progname = nil, &block
        __getobj__.add(severity, message, Thread.current, &block)
      end

      {
        :debug    =>  ::Logger::DEBUG,
        :error    =>  ::Logger::ERROR,
        :fatal    =>  ::Logger::FATAL,
        :info     =>  ::Logger::INFO,
        :unknown  =>  ::Logger::UNKNOWN,
        :warn     =>  ::Logger::WARN
      }.each do |method, severity|

        define_method(method) do |progname = nil, &block|
          name = @thread_names.has_key?(Thread.current) ? @thread_names[Thread.current] : Thread.current
          if block.nil?
            __getobj__.add severity, progname, name, &block
          else
            __getobj__.add severity, nil, "#{name} - #{progname}", &block
          end
        end

      end

    end
  end
end
