require 'word_list_processors/word_list_processor'

class Depluralizer < WordListProcessor

  def depluralize
    word_hash.each do |key, word|
      combine_plural_form_with_singular(key, word)
    end
  end

  def combine_plural_form_with_singular(key, word)
    singular = entry.text.singularize
    if (key != singular) && list.has_key?(singular)
      merge_items(singular, key)
    end
  end

  def merge_items(item_to_keep, item_to_remove)
    list[item_to_keep].hits += list[item_to_remove].hits
    list.delete(item_to_remove)
  end
end