class ArtistsController < ApplicationController
  def index
    @artists = Artist.all
  end
  def new
  end

  def show
    # @artist = Artist.find(params[:id])
    @artist = Artist.find(params[:id])

  end

  def create
    artist_name = params.require(:artist)[:artist_name]
    new_mechanize = MechanizeService.new
    url = new_mechanize.mechanize(artist_name)
    if url.nil? == true
      redirect_to new_artist_path
    else
      @artist = Artist.new(artist_name: artist_name, url: url)

      @artist.save
      redirect_to artist_path(id: @artist.id)
    end
  end

  def destroy
    @artist = Artist.find(params[:id])
    @artist.destroy

    redirect_to artists_path
  end
end
