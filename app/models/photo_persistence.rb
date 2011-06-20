module PhotoPersistence
    UPLOAD_DIR_NAME = "uploads"
    PHOTO_UPLOAD_DIR = "public/images/#{UPLOAD_DIR_NAME}"

    attr_accessor :photo_file

    def photo_filename
        table = self.class.table_name

        if id
            "#{table}_#{id}"
        else
            query = "SELECT auto_increment FROM information_schema.tables WHERE table_name = '#{table}'"
            next_id = self.class.connection.execute(query).to_a.flatten.first
            "#{table}_#{next_id}"
        end
    end

    def save_photo(photo)
        Dir.mkdir(PHOTO_UPLOAD_DIR) unless File.exists?(PHOTO_UPLOAD_DIR)
        extension = File.extname(photo.original_filename)
        
        path = File.join(PHOTO_UPLOAD_DIR, photo_filename + extension)
        File.open(path, "wb") {|f| f.write(photo.read) }
    end

    def delete_photo
        photo_file = Dir["#{PHOTO_UPLOAD_DIR}/#{photo_filename}.*"].first

        if photo_file
            File.delete(photo_file) if File.exists?(photo_file)
        end
    end

    def photo_path_for_view
        path = Dir["#{PHOTO_UPLOAD_DIR}/#{photo_filename}.*"].first

        if path
            filename = File.basename(path)
            "#{UPLOAD_DIR_NAME}/#{filename}"
        else
            ""
        end
    end

    def alternative_photo_filename
        nil
    end

    def has_photo?
       !Dir["#{PHOTO_UPLOAD_DIR}/#{photo_filename}.*"].empty? 
    end
end