require "rails_helper"

describe ScraperService do
  context 'when URL is valid' do
    describe '#scrape_RA' do
      it "saves a title, location and date for all the artist's events" do
        VCR.use_cassette('correct_result') do
          # TO-DO - change this so testing if artist name, location etc scraped separately
          artist = Artist.create(artist_name: 'Jackmaster', url: "https://www.residentadvisor.net/dj/jackmaster/dates?ctry=3")
          noko = NokogiriObject.new(artist)
          noko2 = noko.nokogiri_object
          scraper = ScraperService.new(artist, noko2)
          res = scraper.scrapeRA
          expect(Event.where(artist_id: artist.id, location: "at XOYO, London", event_title: "Artwork + Jackmaster + Kornél Kovács", event_date: "Fri, 16 Feb 2018")).to exist
          expect(Event.where(artist_id: artist.id, location: "at Red Bar, Midlands", event_title: "Wigflex Basement Sessions", event_date: "Fri, 02 Mar 2018")).to exist
          expect(Event.where(artist_id: artist.id, location: "at Canal Mills, Leeds", event_title: "The Garden Party 2018: Part One", event_date: "Sun, 06 May 2018")).to exist
          expect(Event.where(artist_id: artist.id, location: "at Secret Location - Edinburgh, Edinburgh", event_title: "ODYSSEY. 015 - Jackmaster", event_date: "Thu, 17 May 2018")).to exist
          expect(Event.where(artist_id: artist.id, location: "at Damyns Hall Aerodrome, London", event_title: "We Are FSTVL 2018 - Saturday", event_date: "Sat, 26 May 2018")).to exist
          expect(Event.where(artist_id: artist.id, location: "at Riverside Museum, Glasgow", event_title: "Electric Frog & Pressure Riverside Festival 2018", event_date: "Sat, 26 May 2018")).to exist
          expect(Event.where(artist_id: artist.id, location: "at Eastville Park, West + Wales", event_title: "Love Saves The Day 2018 - Saturday", event_date: "Sat, 26 May 2018")).to exist
          expect(Event.where(artist_id: artist.id, location: "at Carreglwyd Estate, West + Wales", event_title: "Gottwood Festival 2018", event_date: "Thu, 07 Jun 2018")).to exist
        end
      end
    end
  end
end
