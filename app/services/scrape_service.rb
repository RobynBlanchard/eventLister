class ScrapeService

  def initialize(artist)
    @artist = artist
  end

  def scrapeRA
    require 'open-uri'
    html_data = open(@artist.url).read
    nokogiri_object = Nokogiri::HTML(html_data)
    list_elements = nokogiri_object.xpath("//ul[@class='list']/li/article/div/h1")
    list_elements.each do |event|
      event_title = event.xpath("a").text
      event_location = event.xpath("span").text
      new_event_model(event_title, event_location, @artist)
    end
  end

  private

  def new_event_model(event, location, artist)
    # TO DO - check new events are added - that it doesn't stop after one existing record found
    unless Event.exists?(artist_id: artist.id, location: location, event_title: event)
      new_event = Event.new(artist_id: artist.id, location: location, event_title: event)
      new_event.save
    end
  end
end
