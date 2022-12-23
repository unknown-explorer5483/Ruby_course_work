json.extract! hotel, :id, :location, :name, :description, :image, :created_at, :updated_at
json.url hotel_url(hotel, format: :json)
json.image url_for(hotel.image)
