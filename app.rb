require 'sinatra'
require 'csv'
require 'fileutils'
require 'rubygems'
require 'active_support/inflector'

Dir["#{settings.root}/classes/*.rb"].each {|file| require file }

class SearchWordApp < Sinatra::Base
  get "/" do
    erb :index
  end

  get "/file/:access_code/:filename" do
    send_file file_path(params[:access_code].gsub(".","")), :filename => params[:filename], :type => 'application/octet-stream'
  end

  post "/" do
    file = SearchDataFile.new(params['file'])
    file.process.write
    @link = "/file/#{file.access_code}/#{file.name}"
    erb :index
  end

  private

  def file_path(filename)
    "#{settings.root}/processed_files/#{filename}.csv"
  end
end
