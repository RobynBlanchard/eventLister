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

  def destroy
    @upload = Upload.find(params[:id])
    @upload.destroy

    redirect_to uploads_path
  end
end
