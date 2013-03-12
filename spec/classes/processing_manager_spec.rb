require 'spec_helper'

describe ProcessingManager do
  let(:word_1) { Word.new("hello",1) }
  let(:word_2) { Word.new("world",2) }
  let(:words) { [word_1, word_2] }
  let(:processor) { ProcessingManager.new(words) }

  describe "#list" do
    it "returns an array" do
      processor.list.should be_a(Array)
    end

    it "includes original list objects" do
      words.each do |word|
        processor.list.include?(word).should be_true
      end
    end
  end
end