require "test/unit"

require_relative "scrape"

class MyTests < Test::Unit::TestCase
  def test_lists_all_games
    assert_equal Game.all.size, 4
  end

  def test_future_game_played
    game = Game.new("1/1/2222", "5pm", "A", "B")
    assert_equal game.played?, false
  end

  def test_past_game_played
    game = Game.new("1/1/1900", "5pm", "A", "B")
    assert_equal game.played?, true
  end

end
