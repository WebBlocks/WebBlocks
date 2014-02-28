module WebBlocks
  module Manager
    class ScssLinkerFile

      attr_reader :base_path
      attr_reader :link_path

      def initialize base_path
        @base_path = base_path
        @link_path = base_path + '.blocks/tmp/scss'
        @import_files = []
      end

      def push file
        @import_files << file
      end

      def save!
        FileUtils.mkdir_p link_path
        File.open(@link_path + 'blocks.scss', 'w') do |f|
          @import_files.each do |file|
            f.puts "@import \"#{file.resolved_path.to_s.gsub /"/, '\\"'}\";"
          end
        end
      end

    end
  end
end