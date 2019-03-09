class Pet < ApplicationRecord
  belongs_to :user 
  
  validates :name, presence:true, length:{maximum:50};
  validates :profile, length:{maximum:255}
  validates :image, length:{maximum:255}
end
