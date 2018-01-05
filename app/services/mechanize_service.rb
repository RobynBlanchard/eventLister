class MechanizeService

  attr_reader :artist

  def initialize(artist)
    @artist = artist
  end

  def mechanize
    # To continue - one responsibliity - if the artist name is correct
    # then return the url, otherwise return nil
    link_to_artist = page.link_with(text: artist)
    if link_to_artist.nil? == true
      return
    else
      page_uri(link_to_artist)
    end
  end

  private
    def page
      mechanize = Mechanize.new
      artists_page = mechanize.get('https://www.residentadvisor.net/dj.aspx')
    end

    def page_uri(link_to_artist)
      page = link_to_artist.click
      events_page = page.link_with(text: 'Events').click
      artist = @artist.downcase.delete(' ')
      # change #{artist} to click on UK button
      link_to_UK_events = events_page.link_with(:href => "/dj/#{artist}/dates?ctry=3").click
      link_to_UK_events.uri.to_s
    end
end
