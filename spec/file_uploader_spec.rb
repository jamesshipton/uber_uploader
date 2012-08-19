require 'spec_helper'

describe UberUploader::FileUploader do
  subject { UberUploader::FileUploader.new(file_record, temp_file) }

  let(:path)        { double('path') }
  let(:chunk)       { double('chunk') }
  let(:file_record) { double('file_record', path: '/path', increase_uploaded_size_by: double('size')) }
  let(:temp_file)   { double('temp_file') }

  before(:each) do
    UberUploader::FileStore.stub(:write)
    temp_file.stub(:read).exactly(3).times.and_return(chunk, chunk, nil)
  end

  it 'uploads the file in chunks' do
    temp_file.should_receive(:read).exactly(3).times.and_return(chunk, chunk, nil)
    subject.upload_file_in_chunks
  end

  it 'increases the file record upload size' do
    file_record.should_receive(:increase_uploaded_size_by).exactly(2).times
    subject.upload_file_in_chunks
  end

  it 'stores the file in a file store' do
    UberUploader::FileStore.should_receive(:write).exactly(2).times.with('lib/uber_uploader/public/path', chunk)
    subject.upload_file_in_chunks
  end
end