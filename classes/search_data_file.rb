class SearchDataFile
  attr_reader :input_path, :original_filename

  def initialize(file_params)
    @input_path = file_params[:tempfile]
    @original_filename = file_params[:filename]
  end

  def write
    CSV.open(output_path, "w") do |csv|
      write_processed_list(csv)
    end
  end

  def name
    "processed_#{original_filename}"
  end

  def access_code
    @access_code ||= SecureRandom.urlsafe_base64(20)
  end

  private

  def words
    @words ||= phrases_to_words
  end

  def phrases_to_words
    phrases.map { |phrase| phrase.words }.flatten
  end

  def phrases
    @phrases ||= csv_to_phrases
  end

  def csv_to_phrases
    CSV.read(input_path).map { |row| row_to_phrase(row) }
  end

  def row_to_phrase(row)
    Phrase.new(:text => row[0], :hits => row[1])
  end

  def processed_list
    @processed_list ||= ProcessingManager.new(words).list
  end

  def write_processed_list(csv)
    processed_list.each do |word|
      csv << [word.text, word.hits]
    end
  end

  def output_path
    @output_path ||= "#{settings.root}/processed_files/#{output_filename}"
  end

  def output_filename
    "#{access_code}.csv"
  end
end
