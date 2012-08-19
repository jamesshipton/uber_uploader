require 'spec_helper'

describe 'Arrive at the file uploader page', :type => :request do
  before(:each) do
    visit '/'
  end

  it 'Display a multipart form' do
    page.should have_selector('form#file-uploader[enctype="multipart/form-data"]')
  end

  it 'Display a file input' do
    page.should have_selector('form#file-uploader input[type="file"]')
  end

  it 'Display a textarea input' do
    page.should have_selector('form#description-uploader textarea')
  end

  it 'Display a disabled submit' do
    page.should have_selector('form#description-uploader input[disabled="disabled"]')
  end
end
