require 'open-uri'

class ScraperService

  attr_reader :artist

  def initialize(artist)
    @artist = artist
  end

  def scrapeRA
    list_elements.each do |event|
      event_title = event.xpath("a").text
      event_location = event.xpath("span").text
      #first_or_create not working, consider using find or create ?
      unless Event.exists?(artist_id: artist.id, location: event_location, event_title: event_title)
        event = Event.create(artist_id: artist.id, location: event_location, event_title: event_title)
        event.save
      end
    end
  end

  private

  def nokogiri_object
    html_data = open(artist.url).read
    Nokogiri::HTML(html_data)
  end

  def list_elements
    nokogiri_object.xpath("//ul[@class='list']/li/article/div/h1")
  end

end
