class Photo
  include PhotoPersistence
  attr_accessor :photo_id

  def initialize(photo_id = nil)
    @photo_id = photo_id.to_i if photo_id
  end

  def photo_filename
    if @photo_id
      "photo_#{@photo_id}"
    else
      last_photo = Dir["#{PHOTO_UPLOAD_DIR}/*.*"].sort.last
      
      if last_photo
        last_photo_id = last_photo.split('_').last.to_i
        next_id = last_photo_id + 1 
        @photo_id = next_id
        "photo_#{next_id}"
      else
        @photo_id = 1
        "photo_1"
      end 
    end     
  end
end
