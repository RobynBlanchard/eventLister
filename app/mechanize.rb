require 'mechanize'

mechanize = Mechanize.new

page = mechanize.get('https://www.residentadvisor.net/dj.aspx')

link = page.link_with(text: 'Denis Sulta')

page = link.click

link_to_event = page.link_with(text: 'Events')

page = link_to_event.click

link_to_UK_events = page.link_with(:href => '/dj/denissulta/dates?ctry=3')

page = link_to_UK_events.click

puts page.uri
