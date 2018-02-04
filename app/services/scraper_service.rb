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
        dates << event_date(event)
      else
        #first_or_create not working, consider using find or create ?
        unless Event.exists?(artist_id: artist.id, location: event_location(event), event_title: event_title(event), event_date: dates[dates_count])
          event = Event.create(artist_id: artist.id, location: event_location(event), event_title: event_title(event), event_date: dates[dates_count])
          event.save
        end
        dates_count += 1
      end
      count +=1
    end
  end

  def event_title(event)
    event.xpath("a").text
  end

  def event_location(event)
    event.xpath("span").text
  end

  def event_date(event)
    event.text.split('/').first.rstrip
  end

  private


  def list_elements
    nokogiri.xpath("//ul[@class='list']/li/article/div/h1")
  end

end
