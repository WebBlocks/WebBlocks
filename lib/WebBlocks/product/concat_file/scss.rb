require 'WebBlocks/product/concat_file/raw'

module WebBlocks
  module Product
    module ConcatFile
      class Scss < Raw

        def content_for file
          "@import \"#{file.resolved_path.to_s.gsub /"/, '\\"'}\";"
        end

      end
    end
  end
end