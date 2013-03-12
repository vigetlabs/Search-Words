class Processor
  attr_reader :word_hash

  def initialize(word_hash)
    @word_hash = word_hash
  end

  def process
    raise NotImplementedError.new("You must implement #process.")
  end
end
