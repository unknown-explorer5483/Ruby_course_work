require 'rails_helper'

RSpec.describe User, type: :model do
    context 'when valid data' do
        it "should write to db correct record" do
            prew_user = User.find_by(username: "testusername")
            prew_user&.destroy

            new_user = User.create(
                username: "testusername", 
                password: "testuser",
                email: "email@gmail.com"
            )
            new_user_search = User.find_by(username: "testusername")
            expect(new_user_search).to eq(new_user)
        end
    end
    context 'when invalid data' do
        it "should not write to db incorrect record" do
            prew_user = User.find_by(username: "testusername")
            prew_user&.destroy

            new_user = User.create(
                username: "tes", 
                password: "testuse",
                email: "emailgmail.com"
            )

            expect(new_user.valid?).to eq(false)
            expect(new_user.errors.full_messages.length).to eq(3)
        end
        it "should not write to db empty record" do
            prew_user = User.find_by(username: "testusername")
            prew_user&.destroy

            new_user = User.create(
            )

            expect(new_user.valid?).to eq(false)
            expect(new_user.errors.full_messages.length).to eq(6)
        end
    end
end
