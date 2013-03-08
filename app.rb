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
    send_file "#{settings.root}/processed_files/#{params[:access_code].gsub(".","")}.csv", :filename => params[:filename], :type => 'Application/octet-stream'
  end

  post "/" do
    file = SearchDataFile.new(params['file'])
    file.process.write
    @link = "/file/#{file.access_code}/#{file.name}"
    erb :index
  end
end
