
class UniqueBooking < ActiveModel::Validator

  def validate(record)
    if Booking.where(room: record.room, date: record.date).length == 2
      record.errors.add :this_room, "#{I18n.t(:room_taken)}"
    end
  end
end

class Booking < ApplicationRecord
  include ActiveModel::Validations

  belongs_to :room
  belongs_to :user

  validates :date, comparison: { greater_than: Time.now }, presence: true
  validate :unique_test


  def unique_test
    p Booking.where(room: room, date: date)
    unless Booking.where(room: room, date: date).empty?

      errors.add :this_room, "#{I18n.t(:room_taken)}"
    end
  end



end



