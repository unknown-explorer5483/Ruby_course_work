class Room < ApplicationRecord
  belongs_to :hotel
  has_many_attached :images

  validates :description, length: { minimum: 25 }, presence: true
  validates :name, length: { minimum: 4 }, presence: true
  validates :cost_per_night, comparison: { greater_than_or_equal_to: 0 }, presence: true
  validates :images, length: { maximum: 4 }
  validates :images, presence: true, on: :create
end
