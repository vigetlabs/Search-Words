require File.join(File.dirname(__FILE__), '..', 'app.rb')

require 'sinatra'
require 'rack/test'
require 'capybara/rspec'
require 'pry'

# setup test environment
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

def app
  SearchWordApp
end

def expect_exception(context, message)
  context.describe "##{message}" do
    it "raises an exception" do
      expect{ processor.send(message) }.to raise_error
    end
  end
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include Capybara::DSL
end

Capybara.app = app