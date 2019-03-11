class User < ApplicationRecord
  
  before_save {self.email.downcase!}
  validates :name, presence:true, length:{maximum:50}
  validates :email,presence:true, length:{maximum:255}, format:{with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}, uniqueness:{case_sensitive: false}
  validates :profile, length:{maximum:255}
  has_secure_password
  
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
end
