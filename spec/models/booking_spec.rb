require 'rails_helper'

RSpec.describe Booking, type: :model do

    describe 'test user' do
        let(:new_hotel) do
            prew_hotel = Hotel.find_by(name: "testhotel")
            prew_hotel&.destroy
            file = Rails.root.join('spec', 'support', 'assets', 'images','hotels' , '370564672.jpg')
            image = ActiveStorage::Blob.create_and_upload!( 
                io: File.open(file, 'rb'),  
                filename: '370564672.jpg',  
                content_type: 'image/jpg'
            ).signed_id
            new_hotel = Hotel.create(
                location: "testlocation", 
                name: "testhotel",
                description: "some description for hotel",
                image: image
            )
            new_hotel
          end

        let(:new_room) do
            prew_room = Room.find_by(name: "testroom")
            prew_room&.destroy
            file = Rails.root.join('spec', 'support', 'assets', 'images', 'rooms' , '0x0.jpg')
            image_room = ActiveStorage::Blob.create_and_upload!( 
                io: File.open(file, 'rb'),  
                filename: '370564672.jpg',  
                content_type: 'image/jpg'
            ).signed_id

            new_room = Room.create(
                hotel: new_hotel,
                cost_per_night: 300.55, 
                name: "testroom",
                description: "some description for room",
                images: [image_room]
            )
            new_room
        end

        let(:new_user) do
            prew_user = User.find_by(username: "testusername")
            prew_user&.destroy

            new_user = User.create(
                username: "testusername", 
                password: "testuser",
                email: "email@gmail.com"
            )
            new_user
        end

        let(:new_user2) do
            prew_user2 = User.find_by(username: "testusername2")
            prew_user2&.destroy

            new_user2 = User.create(
                username: "testusername2", 
                password: "testuser2",
                email: "email2@gmail.com"
            )
            new_user2
        end

        context 'when valid data' do
            it "should write to db correct record" do

                prew_booking = Booking.find_by(user: new_user, room: new_room)
                prew_booking&.destroy
                
                new_booking = Booking.create(
                    room: new_room, 
                    user: new_user,
                    date: Time.now + 1.day,
                )

                new_booking_search = Booking.find_by(user: new_user)
                expect(new_booking_search).to eq(new_booking)

            end
        end 

        context 'when invalid data' do
            it "should not write to db incorrect record" do

                prew_booking = Booking.find_by(user: new_user)

                prew_booking&.destroy
                new_booking = Booking.create(
                    room: new_room, 
                    user: new_user,
                    date: Time.now - 1.day,
                )

                expect(new_booking.valid?).to eq(false)
                expect(new_booking.errors.full_messages.length).to eq(1)

            end
            it "should not write dublicate bookings" do

                prew_booking = Booking.find_by(user: new_user, room: new_room)
                prew_booking&.destroy

                prew_booking2 = Booking.find_by(user: new_user2, room: new_room)
                prew_booking2&.destroy
                new_booking = Booking.create(
                    room: new_room, 
                    user: new_user,
                    date: '01.01.2023',
                )
                new_booking2 = Booking.create(
                    room: new_room, 
                    user: new_user2,
                    date: '01.01.2023',
                )

                expect(new_booking2.valid?).to eq(false)
                expect(Booking.find_by(user: new_user, room: new_room)).to eq(new_booking)
            end
            it "should not write to db empty record" do

                prew_booking = Booking.find_by(user: new_user)

                prew_booking&.destroy
                new_booking = Booking.create(

                )

                expect(new_booking.valid?).to eq(false)
                expect(new_booking.errors.full_messages).to eq(["Room must exist", "User must exist", "Date can't be blank"])

            end
        end

    end
   
end
