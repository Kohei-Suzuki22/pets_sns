class Timeline < ApplicationRecord
  belongs_to :user
  
  validates :content, presence:true, length:{maximum:255}

  has_many :goods, dependent: :destroy
  has_many :liked_users, through: :goods, source: :user
  
  mount_uploader :image, ImageUploader

end
