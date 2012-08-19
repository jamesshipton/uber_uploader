require 'spec_helper'

describe UberUploader::FileRecord do
  subject { UberUploader::FileRecord.new(params, guid) }

  let(:params) { { filename: 'file_name1.txt' } }
  let(:guid)   { 'file_name1.txt_1024' }

  its(:save){ UberUploader::DataStore.should_receive(:set).with(subject) }

  its(:path) { should == '/file_name1_1024.txt' }

  its(:percentage_uploaded) { should == 0 }

  it 'increases its uploaded size' do
    (1..3).each do |i|
      subject.increase_uploaded_size_by(256).instance_variable_get(:@uploaded_size).should == 256 * i
    end
  end

  it 'increases its percentage uploaded' do
    [25, 50, 75, 100].each do |percent|
      subject.increase_uploaded_size_by(256)
      subject.percentage_uploaded.should == percent
    end
  end

  it 'add a description' do
    subject.description = 'description'
    subject.instance_variable_get(:@description).should == 'description'
  end
end