class Phrase
  def initialize(text, hits)
    @hits = convert_to_int(hits)
    @text = clean_string(text)
  end

  def tally
    words.each(&:tally)
  end

  def words
    @words ||= text_to_words(text, hits)
  end

  private

  attr_reader :hits, :text

  def text_to_words(text, hits)
    text.split(" ").map do |word|
      Word.new(word, hits)
    end
  end

  def clean_string(dirty_string)
    dirty_string.squeeze(" ").downcase
  end

  def convert_to_int(string)
    string.gsub(/[^\d\.]/,"").to_i
  end
end
