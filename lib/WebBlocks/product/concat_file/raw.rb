module WebBlocks
  module Product
    module ConcatFile
      class Raw

        attr_reader :path

        def initialize path
          @path = Pathname.new(path)
          @files = []
        end

        def push file
          @files << file
        end

        def content_for file
          IO.read file.resolved_path.to_s
        end

        def save!
          FileUtils.mkdir_p @path.parent
          File.open(@path, 'w') do |f|
            @files.each do |file|
              f.puts "#{content_for file}"
            end
          end
        end

      end
    end
  end
end