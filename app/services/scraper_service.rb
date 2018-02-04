require 'open-uri'

class ScraperService

  attr_reader :artist
  attr_reader :nokogiri

  def initialize(artist, nokogiri)
    @artist = artist
    @nokogiri = nokogiri
  end

  def scrapeRA
    count = 0
    dates = Array.new
    dates_count = 0
    list_elements.each do |event|
      if count%2 == 0
        event_date = event.text.split('/').first.rstrip
        dates << event_date
      else
        event_title = event.xpath("a").text
        event_location = event.xpath("span").text
        #first_or_create not working, consider using find or create ?
        
        unless Event.exists?(artist_id: artist.id, location: event_location, event_title: event_title, event_date: dates[dates_count])
          event = Event.create(artist_id: artist.id, location: event_location, event_title: event_title, event_date: dates[dates_count])
          event.save
        end
        dates_count += 1
      end
      count +=1
    end
  end

  private


  def list_elements
    nokogiri.xpath("//ul[@class='list']/li/article/div/h1")
  end

end
