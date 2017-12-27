class EventsController < ApplicationController
  def index
    # TO DO - Refresh every hour? and only add to model if not there already
    refresh_listings
  end

  def refresh_listings
    Artist.all.each do |artist|
      new_scrape = ScrapeService.new(artist)
      new_scrape.scrapeRA
    end
  end

end
