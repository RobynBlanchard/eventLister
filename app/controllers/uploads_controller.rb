class UploadsController < ApplicationController
  def index
    @artists = Artist.all
  end
  def new
  end

  def show
    @artist = Artist.find(params[:id])
  end

  def create
    @artist = Artist.new(params.require(:upload).permit(:artist_name, :url))

    @artist.save
    redirect_to @artist
  end

  def destroy
    @artist = Artist.find(params[:id])
    @artist.destroy

    redirect_to uploads_path
  end
end
