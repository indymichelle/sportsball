require "bundler"
Bundler.require

class Game
  def initialize(day, time, team1, team2)
    @day = day
    @time = time
    @team1 = team1
    @team2 = team2

  end

  def self.all
    url = "http://www.ccasports.com/teams/3263/marc-lopez-law-presents-kick-it-bounce"

    response = HTTParty.get(url)
    doc = Nokogiri::HTML(response)
    tds = doc.css('td').select do |td|
      td.attributes['colspan'] == nil
    end
    games = []
    tds.each_slice(5) do |td_group|
      day, time, team1, vs, team2 = td_group.map(&:content)
      games.push(Game.new(day, time, team1, team2))
    end
    games
  end

  def played?
    time_day = "#{@day} #{@time}"
    Time.now > Time.parse(time_day)
  end
end
