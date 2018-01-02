class EventsController < ApplicationController
  def index
    artists_and_urls = create_dictionary()
    artist_events_and_location = {}
    Artist.all.each do |user|
      #the code here is called once for each user
      # user is accessible by 'user' variable
    end
    artists_and_urls.each do |artist, url|
      event_and_location = scrapeRA(url)
      events_and_locations[artist] = event_and_location
      @results = events_and_locations
    end
    @results
  end

  def scrapeRA(url)
    require 'open-uri'
    html_data = open(url).read
    nokogiri_object = Nokogiri::HTML(html_data)
    event_elements = nokogiri_object.xpath("//ul[@class='list']/li/article/div/h1/a")
    event_elements_location = nokogiri_object.xpath("//ul[@class='list']/li/article/div/h1/span")
    events = extract_text(event_elements)
    event_locations = extract_text(event_elements_location)
    artist_events_and_locations = Hash[events.zip(event_locations)]
  end

  def extract_text(elements)
    events = []
    elements.each do |event|
      events << event.text
    end
    events
  end

  def create_dictionary()
    @artists = Artist.all
    artists_and_urls = {}
    @artists.each do |artist|
      artists_and_urls[artist.artist_name] = artist.url
    end
    artists_and_urls
  end

end
