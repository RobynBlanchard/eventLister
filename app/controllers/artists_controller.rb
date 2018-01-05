class ArtistsController < ApplicationController
  def index
    @artists = Artist.all
  end
  def new
  end

  def show
    @artist = Artist.find(params[:id])
  end

  def create
    artist_name = params.require(:artist)[:artist_name]
    mechanize = mechanize(artist_name)
    url = mechanize.mechanize
    if url.nil? == true
      flash[:notice] = "Couldn't find this artist"
      redirect_to new_artist_path
    else
      artist = Artist.create(artist_name: artist_name, url: url)
      redirect_to artist_path(id: artist.id)
      #if artist.create fails do something
    end
  end

  def destroy
    @artist = Artist.find(params[:id])
    @artist.destroy

    redirect_to artists_path
  end

  private

  def mechanize(artist_name)
    MechanizeService.new(artist_name)
  end
end
