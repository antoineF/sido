require 'rubygems'
require 'sinatra'
require 'rack/test'
require 'rspec'
require 'rspec/autorun'

# set test environment
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

require File.join(File.dirname(__FILE__), '..', 'sido.rb')

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end