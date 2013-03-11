class Word
  attr_accessor :text, :hits

  def initialize(text, hits)
    @text = text
    @hits = hits
  end
end
