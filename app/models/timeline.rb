class Timeline < ApplicationRecord
  belongs_to :user
  
  validates :content, presence:true, length:{maximum:255}
  validates :image, length:{maximum:255}
  validates :video, length:{maximum:255}
end
