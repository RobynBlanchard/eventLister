require 'open-uri'

class NokogiriObject
  
  attr_reader :artist

  def initialize(artist)
    @artist = artist
  end

  def nokogiri_object
    html_data = open(artist.url).read
    Nokogiri::HTML(html_data)
  end
end
