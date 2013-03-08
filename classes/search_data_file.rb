class SearchDataFile
  attr_reader :input_path, :output_path, :original_filename, :access_code

  def initialize(file_params)
    @access_code = generate_access_code
    @input_path = file_params[:tempfile]
    @output_path = generate_output_path
    @original_filename = file_params[:filename]
  end

  def write
    create_output_file
    CSV.open(output_path, "wb") do |csv|
      write_word_list_to(csv)
    end
  end

  def process
    read_csv
    self
  end

  def name
    "processed_#{original_filename}"
  end

  def word_list
    @word_list ||= Word.depluralized_list
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

  def create_output_file
    FileUtils.touch output_path
  end

  def write_word_list_to(csv)
    word_list.each do |word, hits|
      csv << [word, hits]
    end
  end

  def generate_access_code
    SecureRandom.urlsafe_base64(20)
  end

  def output_filename
    "#{access_code}.csv"
  end

  def generate_output_path
    "#{settings.root}/processed_files/#{output_filename}"
  end
end