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
      it "does not throw an error" do
        VCR.use_cassette('correct_result') do
          artist = Artist.create(artist_name: 'Jackmaster', url: "https://www.residentadvisor.net/dj/jackmaster/dates?ctry=3")
          scraper = ScraperService.new(artist)
          res = scraper.scrapeRA
          byebug
          expect(res.keys).to include('data')
          expect(res['data'].keys).to include('children')
          expect(res['data']['children'].count).to be >= 1
          expect(res['data']['children'][0].keys).to include('data')
          # test more stuff!
        end
      end
    end
  end
end
