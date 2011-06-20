class UploadsController < ApplicationController
  def index
    
  end

  def create
    photo_file = params[:photo]

    if photo_file
        @photo = Photo.new
        @photo.save_photo photo_file
    end

    render :action => 'index'
  end
end
