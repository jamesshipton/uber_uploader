require 'sinatra/base'

module UberUploader
  class Application < Sinatra::Base
    get '/' do
      erb  :uber_uploader_home
    end

    post '/files/:guid/description' do
      if (file_record = DataStore.get(params['guid']))
        file_record.description = params['description']
        file_record.save
      end
    end

    post '/files/:guid' do
      unless (file_record = DataStore.get(params['guid']))
        file_record = FileRecord.new(params['file'], params['guid']).save
        FileUploader.new(file_record, params['file'][:tempfile]).upload_file_in_chunks
      end
    end

    get '/files/:guid/uploaded-percentage' do
      if (file_record = DataStore.get(params['guid']))
        "#{file_record.percentage_uploaded}"
      else
        "0"
      end
    end

    get '/files/:guid' do
      if (file_record = DataStore.get(params['guid']))
        "#{file_record.path}"
      end
    end
  end
end
