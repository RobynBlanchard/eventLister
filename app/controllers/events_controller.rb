class EventsController < ApplicationController
  def index
    get_list_of_artists_and_events
  end

  def get_list_of_artists_and_events
    artists_and_urls = create_dictionary_of_artists_and_urls
    events_and_locations = {}
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

  def create_dictionary_of_artists_and_urls()
    @uploads = Upload.all
    artists_and_urls = {}
    @uploads.each do |upload|
      artists_and_urls[upload.artist] = upload.url
    end
    artists_and_urls
  end

end
