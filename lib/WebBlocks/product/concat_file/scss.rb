require 'WebBlocks/product/concat_file/raw'

module WebBlocks
  module Product
    module ConcatFile
      class Scss < Raw

        def content_for file
          file_path = file.resolved_path.to_s.gsub(/"/, '\\"')
          if file_path.match /\.css$/
            file_path = "CSS:#{file_path.gsub(/\.css$/, '')}" # this syntax is supported by 'sass-css-importer' plugin
          elsif file_path.match /\.scss$/
            file_path.gsub!(/\.scss$/, '') # allow it to resolve with or without underscore by dropping extension
          end
          "@import \"#{file_path}\";"
        end

      end
    end
  end
end