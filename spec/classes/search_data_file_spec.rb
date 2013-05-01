require 'spec_helper'

describe SearchDataFile do
  let(:file) { SearchDataFile.new({ :tempfile => "#{settings.root}/spec/fixtures/files/sample.csv", :filename => "sample.csv" }) }

  describe "#write" do
    let(:filepath) { "#{settings.root}/processed_files/#{file.access_code}.csv" }

    it "writes the proper data to disk" do
      file.write
      File.open(filepath, "rb").read.should == "lemur,3000\ndurham,60\nbull,55\nfighting,10\nblank,0\n"
    end
  end

  describe "#name" do
    it "returns the modified filename" do
      file.name.should == "processed_sample.csv"
    end
  end

  describe "#access_code" do
    before { SecureRandom.stub(:urlsafe_base64).and_return("not-so-random") }

    it "returns the access code" do
      file.access_code.should == "not-so-random"
    end
  end
end
