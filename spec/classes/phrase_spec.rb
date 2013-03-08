require 'spec_helper'

describe Phrase do
  let(:phrase) { Phrase.new(" some Phrase", "1,234") }

  describe "#words" do
    it "returns an array of word objects" do
      phrase.words.should be_a(Array)
      phrase.words.each { |word| word.should be_a(Word) }
    end
  end

  describe "#tally" do
    it "calls #tally on each word in the words array" do
      word = double()
      phrase.stub(:words).and_return([word, word])
      word.should_receive(:tally).exactly(2).times
      phrase.tally
    end
  end
end
