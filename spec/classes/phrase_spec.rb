require 'spec_helper'

describe Phrase do
  let(:phrase) { Phrase.new(:text => " some Phrase", :hits => "1,234") }

  describe "#words" do
    it "returns an array of word objects" do
      phrase.words.should be_a(Array)
      phrase.words.each { |word| word.should be_a(Word) }
    end
  end
end
