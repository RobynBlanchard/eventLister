class UploadsController < ApplicationController
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
