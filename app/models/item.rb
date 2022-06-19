class Item < ApplicationRecord
  belongs_to:genre
attachment :image
 validates :name,presence: true
 validates :introduction,presence: true
 validates :price,presence: true
 validates :image,presence: true
end
