class Comment < ApplicationRecord
  has_many :notifications, dependent: :destroy
  belongs_to :user
  belongs_to :post
  validates :content, presence: true, length: { maximum: 250 }
  validates :user_id, presence: true
  validates :post_id, presence: true
end