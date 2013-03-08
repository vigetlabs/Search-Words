require 'spec_helper'

describe SearchDataFile do
  before { Word.clear_list }
  let(:file) { SearchDataFile.new({ :tempfile => "#{settings.root}/spec/fixtures/files/sample.csv", :filename => "sample.csv" }) }
  
  describe "#process" do
    it "reads a csv into its word_list" do
      file.process
      file.word_list.should == {"lemur"=>3000, "durham"=>60, "bull"=>55, "fighting"=>10}
    end
  end

  describe "#write" do
    let(:filepath) { "#{settings.root}/processed_files/#{file.access_code}.csv" }

    it "writes the proper data to disk" do
      file.process.write
      File.open(filepath, "rb").read.should == "lemur,3000\ndurham,60\nbull,55\nfighting,10\n"
    end
  end

  describe "#name" do
    it "returns the modified filename" do
      file.name.should == "processed_sample.csv"
    end
  end
end
