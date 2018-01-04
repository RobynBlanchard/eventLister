require "rails_helper"

describe ScraperService do
  context 'when URL is valid' do
    describe '#scrape_RA' do
      it "it saves one or more events, if the events are not already saved" do
        artist = Artist.create(artist_name: 'Jackmaster', url: "https://www.residentadvisor.net/dj/jackmaster/dates?ctry=3")
        scraper = ScraperService.new(artist)
        scraper.scrapeRA
        expect(Event.where(artist_id: artist.id)).to exist
      end

      # check that it actually saves an event title, location etc?
    end
  end
end
