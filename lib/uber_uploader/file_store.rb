module UberUploader
  module FileStore
    def self.write file_path, chunk
      File.open(file_path, "ab") { |f| f.write(chunk) }
    end
  end
end