require 'sinatra'
require 'csv'
require 'fileutils'
require 'rubygems'
require 'active_support/inflector'
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'classes'))
Dir.glob(settings.root + '/classes/*.rb') {|file| require file}

class SearchWordApp < Sinatra::Base
  get "/" do
    erb :index
  end

  get "/file/:access_code/:filename" do
    send_file file_path(settings.root, params[:access_code].gsub(".","")), :filename => params[:filename], :type => 'application/octet-stream'
  end

  post "/" do
    return file_selection_error unless csv_file_present?(params['file'])

    begin
      file = SearchDataFile.new(params['file'])
      file.write
      @link = "/file/#{file.access_code}/#{file.name}"
    rescue
      @error = "The provided file could not be processed."
    end

    erb :index
  end

  def file_path(root, filename)
    "#{root}/processed_files/#{filename}.csv"
  end

  def csv_file_present?(file_params)
    file_params &&
    file_params[:filename] =~ /.*\.csv$/ &&
    file_params[:type] == "text/csv"
  end

  def file_selection_error
    @error = "Please select a .csv file."
    erb :index
  end
end
