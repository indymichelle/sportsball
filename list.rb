require "bundler"
Bundler.require

require_relative "game"

TEAMS = [3263, 2450, 3581, 1545, 3277, 51, 1265, 3131, 1814, 3060, 4056, 4057]

games = Game.for_teams(TEAMS)

games.select! { |g| !g.played? }

games.sort.each do |game|
  puts game.simple_description
end
