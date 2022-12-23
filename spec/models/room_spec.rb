require 'rails_helper'

RSpec.describe Room, type: :model do
    
    describe 'test hotel' do
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
            new_hotel.save!
            new_hotel
        end

        context 'when valid data' do
            it "should write to db correct record" do

                prew_room = Room.find_by(name: "testroom")
                prew_room&.destroy
                file = Rails.root.join('spec', 'support', 'assets', 'images', 'rooms' , '0x0.jpg')
                image = ActiveStorage::Blob.create_and_upload!( 
                    io: File.open(file, 'rb'),  
                    filename: '370564672.jpg',  
                    content_type: 'image/jpg'
                ).signed_id

                new_room = Room.create(
                    hotel: new_hotel,
                    cost_per_night: 300.55, 
                    name: "testroom",
                    description: "some description for room",
                    images: [image]
                )
                expect(new_room.valid?).to eq(true)
                new_room.save!
                new_room_search = Room.find_by(name: "testroom")
                expect(new_room_search).to eq(new_room)

            end
        end

        context 'when invalid data' do
            it "should not write to db incorrect record" do
                prew_room = Room.find_by(name: "testroom")
                prew_room&.destroy
                file = Rails.root.join('spec', 'support', 'assets', 'images', 'rooms' , '0x0.jpg')
                image = ActiveStorage::Blob.create_and_upload!( 
                    io: File.open(file, 'rb'),  
                    filename: '0x0.jpg',  
                    content_type: 'image/jpg'
                ).signed_id

                new_room = Room.create(
                    hotel: new_hotel,
                    cost_per_night: -100, 
                    name: "tes",
                    description: "some description",
                    images: [image]
                )
                expect(new_room.valid?).to eq(false)
                expect(new_room.errors.full_messages.length).to eq(3)
            end

            it "should not write to db incorrect record with too many images" do
                prew_room = Room.find_by(name: "test")
                prew_room&.destroy
                file = Rails.root.join('spec', 'support', 'assets', 'images', 'rooms' , '0x0.jpg')
                image_room = ActiveStorage::Blob.create_and_upload!( 
                    io: File.open(file, 'rb'),  
                    filename: '0x0.jpg',  
                    content_type: 'image/jpg'
                ).signed_id

                new_room = Room.create(
                    hotel: new_hotel,
                    cost_per_night: 100, 
                    name: "test",
                    description: "some description for room",
                    images: [image_room,image_room,image_room,image_room,image_room]
                )
                expect(new_room.valid?).to eq(false)
                expect(new_room.errors.full_messages.length).to eq(1)
            end
        end
    end
end
