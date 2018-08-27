class Post < ApplicationRecord
  belongs_to :user, -> { where :activated => true }
  default_scope -> { order( :created_at => :desc ) }
  mount_uploader :picture, PictureUploader
  validates :title, :user_id, :presence => true
  validates :content, :length => { :maximum => 140 } , :presence => true
  validate :picture_size

  private

    # Validates the size of an uploaded picture_size
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end

end