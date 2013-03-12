require 'spec_helper'

describe Depluralizer do
  context "initialized with a list not containing combinable plurals" do
    let(:processor) { Depluralizer.new({ 'lemur' => Word.new('lemur', 1), 'monkey' => Word.new('monkey', 2) }) }

    describe "#process" do
      it "does not combine entries" do
        processor.process.count.should == 2
      end
    end
  end

  context "intialized with a list containing combinable plurals" do
    let(:processor) { Depluralizer.new({ 'lemur' => Word.new('lemur', 1), 'lemurs' => Word.new('lemurs', 2) }) }

    describe "#process" do
      it "removes entries" do
        processor.process.count.should == 1
      end

      it "keeps the singular entry" do
        processor.process.has_key?('lemur').should be_true
      end

      it "increments the hits value of the singular entry" do
        processor.process['lemur'].hits.should == 3
      end
    end
  end
end