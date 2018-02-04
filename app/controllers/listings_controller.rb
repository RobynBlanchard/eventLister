class ListingsController < ApplicationController
  def index
    # TO DO - Refresh every hour? or if new artist added?
    refresh_listings
  end

  def refresh_listings
    # TO DO - move into a refresh service?
    Artist.all.each do |artist|
      new_noko = NokogiriObject.new(artist)
      noko = new_noko.nokogiri_object
      new_scrape = ScraperService.new(artist, noko)
      new_scrape.scrapeRA
    end
  end

  def title(page_title)
    content_for :title, "Listings"
  end

end
