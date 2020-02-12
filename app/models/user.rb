class User < ApplicationRecord
  has_many :active_notifications, class_name: 'Notification', 
                                  foreign_key: 'visitor_id', 
                                  dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', 
                                   foreign_key: 'visited_id', 
                                   dependent: :destroy
  has_many :following_notice, through: :active_notifications, source: :visited
  has_many :follower_notice, through: :passive_notifications, source: :visitor
  has_many :comments, dependent: :destroy
  has_many :comment_notice, through: :passive_notifications, source: :post
  # favorites
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :fav_lists, through: :favorites, source: :post
  has_many :favorite_notice, through: :passive_notifications, source: :post
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                  foreign_key: "followed_id",
                                  dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :omniauthable, omniauth_providers: %i[facebook]
  before_save { self.user_name = user_name.downcase }
  validates :name,  presence: true, length: { maximum: 50 }
  validates :user_name, presence: true, length: { maximum: 50 },
              uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
      user.user_name = User.new_token
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # ユーザーのステータスフィードを返す
  def feed
    following_ids = "SELECT followed_id FROM relationships
                      WHERE follower_id = :user_id"
    Post.where("user_id IN (#{following_ids})
                      OR user_id = :user_id", user_id: id)
  end


  # ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

  def create_notification_follow(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

  # 投稿をお気に入りする
  def like(post)
    favorites.create(post_id: post.id)
  end

  # お気に入りを解除する
  def unlike(post)
    favorites.find_by(post_id: post.id).destroy
  end

  # お気に入りされていたらtrueを返す
  def like?(post)
    fav_lists.include?(post)
  end

  # フォローしていたらtrueを返す
  def following_notice?(other_user)
    following_notice.include?(other_user)
  end

  # フォローされていたらtrueを返す
  def follower_notice?(other_user)
    follower_notice.include?(other_user)
  end

  # お気に入りの通知があればtrueを返す
  def favorite_notice?(post)
    favorite_notice.include?(post)
  end

  # お気に入りの通知があればtrueを返す
  def comment_notice?(post)
    comment_notice.include?(post)
  end

  
end