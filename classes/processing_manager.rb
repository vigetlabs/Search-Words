require 'processors/depluralizer'
require 'processors/stop_word_remover'

class ProcessingManager
  attr_reader :raw_list

  def initialize(raw_list)
    @raw_list = raw_list
  end

  def list
    processed_list.map { |key, entry| entry }
  end

  private

  def processed_list
    @processed_list ||= combined_list.tap do |list|
      StopWordRemover.new(list).process
      Depluralizer.new(list).process
    end
  end

  def combined_list
    raw_list.inject({}) do |processed_list, entry|
      combine_entry(processed_list, entry)
      processed_list
    end
  end

  def combine_entry(list, entry)
    key = entry.text
    if list.has_key?(key)
      list[key].hits += entry.hits
    else
      list[key] = entry
    end
  end
end