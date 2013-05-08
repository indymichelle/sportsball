require "bundler"
Bundler.require

require "test/unit"

require_relative "game"

class MyTests < Test::Unit::TestCase
  def test_lists_all_games
    assert_equal 4, Game.for_team(3263).size
  end

  def test_future_game_played
    game = Game.new("1/1/2222", "5pm", "A", "B")
    assert_equal false, game.played?
  end

  def test_past_game_played
    game = Game.new("1/1/1900", "5pm", "A", "B")
    assert_equal true, game.played?
  end

  def test_lists_all_games_mult_teams
    assert_equal 8, Game.for_teams([3263, 3264]).size
  end

  def test_sorting_games
    first  = Game.new("1/1/2000", "4pm", "A", "B")
    second = Game.new("1/1/2000", "5pm", "A", "B")
    last   = Game.new("1/1/2222", "5pm", "A", "B")
    assert_equal [first, second, last], [last,first,second].sort
  end
end
