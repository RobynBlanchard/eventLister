class EventsController < ApplicationController
  def index
    artists_and_urls = create_dictionary()
    artist_events_and_location = {}
    artists_and_urls.each do |artist, url|
      result = scrapeRA(url)
      artist_events_and_location[artist] = result
      @results = artist_events_and_location
    end
    @results

  end

  def scrapeRA(url)
    require 'open-uri'
    html_data = open(url).read
    nokogiri_object = Nokogiri::HTML(html_data)
    event_elements = nokogiri_object.xpath("//ul[@class='list']/li/article/div/h1/a")
    event_elements_location = nokogiri_object.xpath("//ul[@class='list']/li/article/div/h1/span")
    events = get_info(event_elements)
    event_locations = get_info(event_elements_location)
    artist_event_and_location = Hash[events.zip(event_locations)]
  end

  def get_info(elements)
    events = []
    elements.each do |event|
      events << event.text
    end
    events
  end

  def create_dictionary()
    @uploads = Upload.all
    artists_and_urls = {}
    @uploads.each do |upload|
      artists_and_urls[upload.artist] = upload.url
    end
    artists_and_urls
  end

  def mechanise(artist_name)
    require 'mechanize'
    mechanize = Mechanize.new
    page = mechanize.get('https://www.residentadvisor.net/dj.aspx')
    link = page.link_with(text: artist_name)
    page = link.click
    link_to_event = page.link_with(text: 'Events')
    page = link_to_event.click
    artist = artist_name.downcase.delete(' ')
    # TO DO: change this to click link with text UK
    link_to_UK_events = page.link_with(:href => "/dj/#{artist}/dates?ctry=3")
    page = link_to_UK_events.click
    page.uri.to_s
  end


end
