# Gemfile
require "rubygems"
require "bundler/setup"
require "sinatra"
require "./app"
 
set :run, false
set :raise_errors, false
 
run SearchWordApp