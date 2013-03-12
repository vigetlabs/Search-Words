require 'processors/processor'

class Depluralizer < Processor
  def process
    word_hash.each do |key, word|
      combine_plural_form_with_singular(key, word)
    end
  end

  private

  def combine_plural_form_with_singular(key, word)
    singular = word.text.singularize
    if (key != singular) && word_hash.has_key?(singular)
      merge_items(singular, key)
    end
  end

  def merge_items(keep, remove)
    word_hash[keep].hits += word_hash[remove].hits
    word_hash.delete(remove)
  end
end
