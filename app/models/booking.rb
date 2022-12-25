
class Booking < ApplicationRecord
  include ActiveModel::Validations

  belongs_to :room
  belongs_to :user

  validates :date, comparison: { greater_than: Time.now }, presence: true
  before_validation :unique_test


  def unique_test
    unless Booking.where(room: room, date: date).empty?
      errors.add :this_room, "#{I18n.t(:room_taken)}"
    end
  end



end



