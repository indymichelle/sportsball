class Game
  LINGERTIME = (60*60*5) # amount of time after game has started that it will still display - 5 hrs
  attr_accessor :day, :time, :team1, :team2
  def initialize(day, time, team1, team2)
    @day = day
    @time = time
    @team1 = team1
    @team2 = team2
  end

  def self.for_team(team_id)
    url = "http://www.ccasports.com/teams/#{team_id}/"

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

  def self.for_teams(team_ids)
    team_ids.map do |id|
      Game.for_team(id)
    end.flatten
  end




  def game_time
    time_day = "#{@day} #{@time} EDT"
    timezone = TZInfo::Timezone.get('America/New_York')
    Time.parse(time_day)
    utctime = Time.parse(time_day).utc
    timezone.utc_to_local(utctime)
  end

  def simple_description
    "%20s %8s   #{@team1} vs #{@team2}" % [@day, @time]
  end

  def <=>(other)
    game_time <=> other.game_time
  end

  def display?
    Time.now - LINGERTIME < self.game_time
  end

end
