class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :favorites
  has_many :users, through: :favorites
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :picture, presence: true
  validate  :picture_size

  def self.explore(explore)
    if explore
      Post.where(['text LIKE ?', "%#{explore}%"])
    else
      Post.all
    end
  end

  private

    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
