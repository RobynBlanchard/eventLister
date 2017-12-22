class UploadsController < ApplicationController
  def index
    @uploads = Upload.all
  end

  def new
  end

  def show
    @upload = Upload.find(params[:id])
  end

  def create
    artist = params[:artist]
    url = mechanise(artist)
    @upload = Upload.new(artist: artist, url: url)
    @upload.save
    redirect_to @upload
  end

  def destroy
    @upload = Upload.find(params[:id])
    @upload.destroy

    redirect_to uploads_path
  end

  def mechanise(artist_name)
    require 'mechanize'
    mechanize = Mechanize.new
    page = mechanize.get('https://www.residentadvisor.net/dj.aspx')
    link = page.link_with(text: artist_name)
    page = link.click
    link_to_event = page.link_with(text: 'Events')
    page = link_to_event.click
    artist = artist_name.downcase.delete(' ')
    # TO DO: change this to click link with text UK
    link_to_UK_events = page.link_with(:href => "/dj/#{artist}/dates?ctry=3")
    page = link_to_UK_events.click
    page.uri.to_s
  end
end
