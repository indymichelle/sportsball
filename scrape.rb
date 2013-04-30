require "bundler"
Bundler.require

url = "http://www.ccasports.com/teams/1814/beast-mode"

response = HTTParty.get(url)
doc = Nokogiri::HTML(response)
tds = doc.css('td').select do |td|
  td.attributes['colspan'] == nil
end

tds.each_slice(5) do |td_group|
  day, time, team1, vs, team2 = td_group.map(&:content)
  day_time = day + " " + time
  if Time.now < Time.parse(day_time)
    puts("#{day_time} #{team1} vs #{team2}")
  end
end
