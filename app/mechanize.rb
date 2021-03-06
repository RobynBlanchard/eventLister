require 'mechanize'

def mechanize(artist)
  mechanize = Mechanize.new

  page = mechanize.get('https://www.residentadvisor.net/dj.aspx')

  link = page.link_with(text: artist)

  page = link.click

  link_to_event = page.link_with(text: 'Events')

  page = link_to_event.click
  artist = artist.downcase.delete(' ')
  link_to_UK_events = page.link_with(:href => "/dj/#{artist}/dates?ctry=3")

  page = link_to_UK_events.click

  puts page.uri
end
