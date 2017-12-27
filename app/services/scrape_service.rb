class ScrapeService

  def initialize(artist)
    @artist = artist
  end

  def scrapeRA
    require 'open-uri'
    html_data = open(@artist.url).read
    nokogiri_object = Nokogiri::HTML(html_data)
    # event_elements = nokogiri_object.xpath("//ul[@class='list']/li/article/div/h1/a")
    event_elements_location = nokogiri_object.xpath("//ul[@class='list']/li/article/div/h1/span")
    new_event_model(event_elements_location, @artist)
  end

  private

  def new_event_model(elements, artist)
    elements.each do |event|
      # TO DO - check new events are added - that it doesn't stop after one existing record found
      unless Event.exists?(artist_id: artist.id, location: event.text)
        new_event = Event.new(artist_id: artist.id, location: event.text)
        new_event.save
      end
    end
  end
end
