require 'spec_helper'

describe Word do
  before { Word.clear_list }

  context "class methods" do
    before do
      Word.new("lemur",10).tally
      Word.new("lemurs",10).tally
      Word.new("lemur",10)
    end

    describe ".list" do
      it "returns a list of tallied words" do
        Word.list.should == {"lemur" => 10, "lemurs" => 10}
      end
    end

    describe ".list" do
      it "returns a list of tallied words with plural forms collapsed onto singular forms" do
        Word.depluralized_list.should == {"lemur" => 20}
      end
    end

    describe ".clear_list" do
      it "resets the list to an empty hash" do
        Word.clear_list.list.should == {}
      end
    end
  end

  context "instance methods" do
    describe "#tally" do
      context "when a word is a stop word" do
        let(:word) { Word.new("a",10) }

        it "is not added to the word list" do
          expect{word.tally}.to_not change{Word.list}
        end
      end

      context "when a word is not a stop word" do
        let(:word) { Word.new("lemur",10) }

        context "and it does not already exist in the word list" do
          it "is added to the word list" do
            word.tally
            Word.list.should == {"lemur" => 10}
          end
        end

        context "and it already exists in the word list" do
          before { Word.new("lemur",5).tally }

          it "adds its hits value to the existing value in the word list" do
            word.tally
            Word.list.should == {"lemur" => 15}
          end
        end
      end
    end
  end
end