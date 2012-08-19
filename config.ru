$LOAD_PATH.unshift File.dirname(__FILE__) + '/lib'

require 'uber_uploader'

run UberUploader::Application
