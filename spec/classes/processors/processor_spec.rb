require 'spec_helper'

describe Processor do
  let(:processor) { Processor.new({:a => :b}) }

  describe "#process" do
    it "raises an implementation error" do
      expect{ processor.process }.to raise_error(NotImplementedError)
    end
  end

  describe "#word_hash" do
    it "returns the word hash" do
      processor.word_hash.should == {:a => :b}
    end
  end
end