class ListProcessor
  include Depluralizer, StopWordRemover

  def initialize(raw_list)
    @raw_list = raw_list
    @options = {}
  end

  def combine(values, params)
    set_option(:values, values)
    params.each { |key, value| set_option(key, value) }
    self
  end

  def list
      keyed_list.map { |key, entry| entry }
  end

  private

  attr_reader :raw_list
  attr_accessor :options

  def keyed_list
    @keyed_list ||= combine!(@raw_list)
  end

  def set_option(option, value)
    options[option] = value
  end

  def combine!(list)
    raise "Must set 'on' option for keying." if options[:on].nil?
    raise "Must set 'values' option for keying." if options[:values].nil?

    processed_list = {}
    list.flatten.each do |entry|
      combine_entry(processed_list, entry)
    end
    processed_list
  end

  def combine_entry(list, entry)
    key = entry.send(options[:on])
    if list.has_key?(key)
      combination_value = entry.send(options[:values]) + list[key].send(options[:values])
      list[key].send("#{options[:values]}=", combination_value)
    else
      list[key] = entry
    end
  end

  def require_keyed_list(msg = "Keyed list required. Use #combine to key the raw list.")
    raise msg if keyed_list.nil?
  end
end