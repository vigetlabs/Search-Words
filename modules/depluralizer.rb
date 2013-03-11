module Depluralizer
  def depluralize
    require_keyed_list
    depluralize!(keyed_list)
    self
  end

  private

  def depluralize!(list)
    list.each do |key, entry|
      combine_plural_form_with_singular(key, entry, list)
    end
  end

  def combine_plural_form_with_singular(key, entry, list)
    singular = entry.send(options[:on]).singularize
    if (key != singular) && list.has_key?(singular)
      merge_items(singular, key, entry.send(options[:values]), list)
    end
  end

  def merge_items(item_to_keep, item_to_remove, increment, list)
    combination_value = list[item_to_keep].send(options[:values]) + increment
    list[item_to_keep].send("#{options[:values]}=", combination_value)
    list.delete(item_to_remove)
  end
end