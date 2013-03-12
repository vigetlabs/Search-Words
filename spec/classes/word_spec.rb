require 'spec_helper'

describe Word do
  let(:word) { Word.new("text", 42) }

  describe "#text" do
    it "returns the proper text" do
      word.text.should == "text"
    end
  end

  describe "#hits" do
    it "returns the proper hits count" do
      word.hits.should == 42
    end
  end
end