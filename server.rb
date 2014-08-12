require "bundler"
Bundler.require

require 'sinatra/reloader' unless ENV['RACK_ENV'] == 'production'
require_relative "game"

TEAMS = [3263, 2450, 3581, 1545, 3277, 51, 1814, 1265, 3060, 3764, 1593, 4395]


get '/' do
  @games = Game.for_teams(TEAMS)
  @games.select! { |g| g.display? }
  @games.sort!
  erb :index
end


