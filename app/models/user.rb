class User < ActiveRecord::Base
  attr_accessible :email, :password, :username, :profile_bg, :profile_fg, :image

  after_save :store_image

  validates_presence_of :email
  validates_presence_of :password, :on => :create
  validates_presence_of :username
  validates_uniqueness_of :username, :message => "That username is already taken."
  validates_uniqueness_of :email, :message => "Email address already in use."
  validates_length_of :username, :minimum => 1, :maximum => 40, :message => "Username must be between 1 and 40 characters long." 
  validates_length_of :password, :minimum => 6
  validates_format_of :email, :with => /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/
  validates_exclusion_of :username, :in => ['admin', 'leo','kyle']
  # %w(admin), :in => %w(leo), :in => %w(kyle), :message => "That username is forbidden"

# 	def username_is_not_forbidden?
# 		if self.username.downcase == "admin" ||
# 			self.username.downcase == "kyle" ||
# 			self.username.downcase == "leo"
# 			true
# 		else
# 			false
# 		end
# 	end

IMAGE_STORE = "#{Rails.root}/public/image_store"

 def image_filename
    return "#{IMAGE_STORE}/#{id}.#{profile_image}"
  end

  # at upload assign file_data to instance var and grab image type 
  def image=(file_data)
    unless file_data.blank?
    # assign uploaded data to instance variable
      @file_data = file_data
    # assign image type (extension) to self.profile_image
      self.profile_image = file_data.original_filename.split('.').last.downcase
     end 
  end
  # define method to retrieve relative URI for the stored image # in the /public directory of the app, for use in HTML
  def image_uri
    return "/image_store/#{id}.#{profile_image}"
  end
# define method to determine if a review has an image on the # file system at the location specified by image_filename 
  def has_image?
    return File.exists? image_filename 
  end

  private
  def store_image
   if @file_data
      # create directory at IMAGE_STORE if it does not exist
      FileUtils.mkdir_p IMAGE_STORE
      # save image to file location and name from image_filename method 
      File.open(image_filename, 'wb') do |f|
        f.write(@file_data.read) 
      end
      # nil file_data in memory so it won't be resaved
      @file_data = nil 
    end
  end
end



