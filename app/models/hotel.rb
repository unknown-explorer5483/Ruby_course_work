class Hotel < ApplicationRecord
  has_one_attached :image

 
  validates :location, length: { minimum: 4 }, presence: true
  validates :name, length: { minimum: 4 }, presence: true
  validates :description, length: { minimum: 25 }, presence: true
  validates :image, presence: true
end
