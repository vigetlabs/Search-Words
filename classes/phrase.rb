class Phrase
  attr_reader :words

  def initialize(text, hits)
    hits = clean_int(hits)
    text = clean_string(text)
    @words = text_to_words(text, hits)
  end

  def tally
    words.each { |word| word.tally }
  end

  private

  def text_to_words(text, hits)
    text.split(" ").inject([]) do |word_array, word|
      word_array << Word.new(word, hits)
    end
  end

  def clean_string(dirty_string)
    dirty_string.squeeze(" ").downcase
  end

  def clean_int(dirty_int)
    if [Integer, Fixnum, Float].include? dirty_int.class
      dirty_int
    else
      dirty_int.gsub(/[^\d]/,"").to_i 
    end
  end
end