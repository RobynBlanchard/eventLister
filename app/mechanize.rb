require 'mechanize'

mechanize = Mechanize.new

page = mechanize.get('https://www.residentadvisor.net/dj.aspx')

link = page.link_with(text: 'Denis Sulta')

page = link.click

link_to_event = page.link_with(text: 'Events')

page = link_to_event.click

#link_to_UK_events = page.link_with(text: '&nbsp; UK')
#link_to_UK_events = page.link_with(text: 'UK')
next_page = page.at('#Form1 > main > ul > li > section > div > ul > li.fl.col2 > div:nth-child(4) > ul > li:nth-child(25) > div:nth-child(2) > a')
#page = next_page.click

#page = link_to_UK_events.click

puts next_page.methods
