require 'spec_helper'

describe StopWordRemover do
  context "initialized with a list not containing stop words" do
    let(:processor) { StopWordRemover.new({ 'lemur' => Word.new('lemur', 1), 'monkey' => Word.new('monkey', 2) }) }

    describe "#process" do
      it "does not combine entries" do
        processor.process.count.should == 2
      end
    end
  end

  context "intialized with a list containing stop words" do
    let(:processor) { StopWordRemover.new({ 'lemur' => Word.new('lemur', 1), 'a' => Word.new('a', 500) }) }

    describe "#process" do
      it "removes stop word entries" do
        processor.process.has_key?('a').should be_false
      end
    end
  end
end