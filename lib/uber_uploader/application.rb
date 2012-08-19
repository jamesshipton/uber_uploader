require 'sinatra/base'

module UberUploader
  class Application < Sinatra::Base
    get '/' do
      erb  :uber_uploader_home
    end
  end
end
