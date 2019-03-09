require 'rspec'
require 'rack/test'
require 'ffaker'
require "pg_search"
require_relative '../app.rb'
 
Dir["./spec/support/**/*.rb"].each { |f| require f }
Dir["./app/services/**/*.rb"].each {|file| require file }
 
set :environment, :test
 
module RSpecMixin
  include Rack::Test::Methods
 
  def app
    App
  end
end
 
RSpec.configure do |c|
  c.include RSpecMixin
  ActiveRecord::Base.logger = nil
  ENV['LOG'] == true
end