module UberUploader
  class FileRecord
    attr_writer :description
    attr_reader :guid

    def initialize params, guid
      @guid = guid
      @name = params[:filename].match(file_name_parsing_regex)[1]
      @type = params[:filename].match(file_name_parsing_regex)[2]
      @size = guid.match(guid_parsing_regex)[1]
      @uploaded_size = 0
    end

    def path
      "/#{@name}_#{@size}.#{@type}"
    end

    def percentage_uploaded
      (@uploaded_size.to_f / @size.to_f * 100).to_i
    end

    def increase_uploaded_size_by value
      @uploaded_size += value
      save
    end

    def save
      DataStore.set self
    end

    private
    def file_name_parsing_regex
      /^(.+)\.([a-zA-Z0-9]+)$/
    end

    def guid_parsing_regex
      /^.+_([0-9]+)$/
    end
  end
end