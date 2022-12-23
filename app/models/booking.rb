
class UniqueBooking < ActiveModel::Validator
  def validate(record)
    if Booking.where(room: record.room, date: record.date).length == 2
      record.errors.add :taken, "This room has already been taken"
    end
  end
end

class Booking < ApplicationRecord
  include ActiveModel::Validations

  belongs_to :room
  belongs_to :user

  validates :date, comparison: { greater_than: Time.now }, presence: true
  validates_with UniqueBooking
  



end



