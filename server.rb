require "bundler"
Bundler.require

require 'sinatra/reloader' unless ENV['RACK_ENV'] == 'production'
require_relative "game"

TEAMS = [3263, 2450]


get '/' do
  @games = Game.for_teams(TEAMS)
  @games.select! { |g| !g.played? }
  erb :index
end
