class UploadsController < ApplicationController
  def index
    rest_graph.get('me')
  end

  def create
    photo_file = params[:photo]
    access_token = rest_graph.access_token
    session[:token] = access_token if access_token && !access_token.empty?

    if photo_file
        @photo = Photo.new
        @photo.save_photo photo_file
    end

    render :action => 'index'
  end

  def facebook
    id = params[:id]
    access_token = session[:token]
    graph_url = "https://graph.facebook.com/me/photos"
    photo_path = Dir["#{PhotoPersistence::PHOTO_UPLOAD_DIR}/photo_#{id}.*"].first
    notice = nil
    
    RestClient.post(graph_url, :access_token => access_token, :photo => File.new(photo_path, 'rb')) do |response, request, result|
      status_ok = 200

      case response.code
        when status_ok
          notice = "Photo successfully uploaded"
          puts notice
        else
          notice = "Upload failed - RESPONSE_CODE = #{response.code}"
          puts notice
      end
    end

    render :action => 'index', :notice => notice
  end
end
