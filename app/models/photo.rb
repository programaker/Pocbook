class Photo
  include PhotoPersistence
  attr_accessor :id

  def photo_filename
    last_photo = Dir["#{PHOTO_UPLOAD_DIR}/*.*"].sort.last
    
    if last_photo
      last_photo_id = last_photo.split('_').last.to_i
      next_id = last_photo_id + 1 
      @id = next_id
      "photo_#{next_id}"
    else
      @id = 1
      "photo_1"
    end      
  end
end
