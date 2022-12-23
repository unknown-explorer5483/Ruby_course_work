class Booking < ApplicationRecord
  belongs_to :room
  belongs_to :user

  validates :date, comparison: { greater_than: Time.now }

  validates_uniqueness_of :user, scope: [:room, :date]




end


