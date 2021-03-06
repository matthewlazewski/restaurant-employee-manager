ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])
require 'dotenv/load'

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)


require 'sinatra/flash'
require './app/controllers/application_controller'
require './app/controllers/job_controller'
require './app/controllers/post_controller'
require './app/controllers/user_controller'
require_all 'app'
