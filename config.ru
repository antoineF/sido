require 'rubygems'
require 'sinatra'

set :environment, :development
set :run, false

require 'sido'
run Sinatra::Application