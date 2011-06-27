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

  def update
    photo_id = params[:id]
    access_token = rest_graph.access_token
    
    graph_url = "https://graph.facebook.com/me/photos"
    photo_path = Dir["#{PhotoPersistence::PHOTO_UPLOAD_DIR}/photo_#{photo_id}.*"].first
    
    RestClient.post(graph_url, :access_token => access_token, :photo => File.new(photo_path, 'rb')) do |response, request, result|
      status_ok = 200

      case response.code
        when status_ok
          puts ">>> Photo successfully uploaded"
          photo_fb_id = response.split(':').last.split('"')[1]
          rest_graph.post("#{photo_fb_id}/comments", :message => params[:comment], :photo_fb_id => photo_fb_id)
        else
          puts ">>> Upload failed - RESPONSE_CODE = #{response.code}"
      end
    end

    Photo.new(photo_id).delete_photo
    render :action => 'index'
  end
end
