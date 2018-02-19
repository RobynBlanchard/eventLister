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
    @locations = save_locations_in_table(Event.all)
  end

  def title(page_title)
    content_for :title, "Listings"
  end

#instead of location list, create new model that belongs to event
  def save_locations_in_table(events)
    location_list = Array.new
    Event.all.each do |e|
      location = e.location .split(',').last.lstrip
      location_list << location unless location_list.include?(location)
    end
    location_list
  end

end
