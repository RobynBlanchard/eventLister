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
    @upload = Upload.new(params.require(:upload).permit(:artist, :url))

    @upload.save
    redirect_to @upload
  end
end
