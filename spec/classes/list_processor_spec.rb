require 'spec_helper'

describe ListProcessor do
  let(:word_1) { Word.new("hello",1) }
  let(:word_2) { Word.new("world",2) }
  let(:words) { [word_1, word_2] }
  let(:processor) { ListProcessor.new(words) }

  describe "#combine" do
    it "returns self" do
      processor.combine(:hits, :on => :text).should == processor
    end
  end

  describe "#list" do
    before { processor.combine(:hits, :on => :text) }

    it "returns an array" do
      processor.list.should be_a(Array)
    end

    it "includes original list objects" do
      words.each do |word|
        processor.list.include?(word).should be_true
      end
    end
  end

  describe "modules" do
    describe Depluralizer do
      context "with a keyed list" do
        before { processor.combine(:hits, :on => :text) }

        describe "#depluralize" do
          context "when there is a plural in the list" do
            let(:word_3) { Word.new("worlds",4) }
            before { words << word_3 }

            it "shortens the list output" do
              pre_list = processor.list
              processor.depluralize
              processor.list.count.should < pre_list.count
            end
          end

          context "when there is not a plural in the list" do
            it "does not change the list output" do
              pre_list = processor.list
              processor.depluralize
              processor.list.should == pre_list
            end
          end

          it "returns self" do
            processor.depluralize.should == processor
          end
        end
      end

      context "without a keyed list" do
        expect_exception(self, "depluralize")
      end
    end

    describe StopWordRemover do
      context "with a keyed list" do
        before { processor.combine(:hits, :on => :text) }

        describe "#remove_stop_words" do
          context "when there is a stop word in the list" do
            let(:word_3) { Word.new("a",4) }
            before { words << word_3 }

            it "shortens the list output" do
              pre_list = processor.list
              processor.remove_stop_words
              processor.list.count.should < pre_list.count
            end
          end

          context "when there is not a stop word in the list" do
            it "does not change the list output" do
              pre_list = processor.list
              processor.remove_stop_words
              processor.list.should == pre_list
            end
          end

          it "returns self" do
            processor.remove_stop_words.should == processor
          end
        end
      end

      context "without a keyed list" do
        expect_exception(self, "remove_stop_words")
      end
    end
  end
end