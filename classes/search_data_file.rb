class SearchDataFile
  attr_reader :input_path, :original_filename

  def initialize(file_params)
    @input_path = file_params[:tempfile]
    @original_filename = file_params[:filename]
  end

  def write
    CSV.open(output_path, "w") do |csv|
      write_word_list_to(csv)
    end
  end

  def process
    Word.clear_list
    read_csv
    self
  end

  def name
    "processed_#{original_filename}"
  end

  def word_list
    @word_list ||= Word.depluralized_list
  end

  def access_code
    @access_code ||= SecureRandom.urlsafe_base64(20)
  end

  def output_path
    @output_path ||= "#{settings.root}/processed_files/#{output_filename}"
  end


  private

  def row_to_phrase(row)
    Phrase.new(row[0], row[1]).tally
  end
  
  def read_csv
    CSV.foreach(input_path) do |row|
      row_to_phrase(row)
    end
  end

  def write_word_list_to(csv)
    word_list.each do |word, hits|
      csv << [word, hits]
    end
  end

  def output_filename
    "#{access_code}.csv"
  end
end
