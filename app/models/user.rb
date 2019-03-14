class User < ApplicationRecord
  
  before_save {self.email.downcase!}
  validates :name, presence:true, length:{maximum:50}
  validates :email,presence:true, length:{maximum:255}, format:{with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}, uniqueness:{case_sensitive: false}
  validates :profile, length:{maximum:255}
  has_secure_password
  
  
  mount_uploader :image, ImageUploader
  
  has_many :pets
  
  has_many :timelines
  
  has_many :goods
  has_many :like_timelines, through: :goods, source: :timeline
  
  def good(timeline)
    self.goods.find_or_create_by(timeline_id: timeline.id)
  end 
  
  def ungood(timeline)
    good_timeline = self.goods.find_by(timeline_id: timeline.id)
    good_timeline.destroy if good_timeline
  end 
  
  def good?(timeline)
    self.like_timelines.include?(timeline)
  end
  
  has_many :friendships 
  has_many :followings, through: :friendships, source: :follow
  has_many :reverse_friendships, class_name: "Friendship", foreign_key: "follow_id"
  has_many :followers, through: :reverse_friendships, source: :user
  
  def follow(other_user)
    unless self == other_user 
      self.friendships.find_or_create_by(follow_id: other_user.id)
    end
  end
  
  def unfollow(other_user)
    friendship = self.friendships.find_by(follow_id: other_user.id)
    friendship.destroy if friendship
  end
  
  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def following_timelines 
    Timeline.where(user_id: self.following_ids.push(self.id))
  end
  
  
end
