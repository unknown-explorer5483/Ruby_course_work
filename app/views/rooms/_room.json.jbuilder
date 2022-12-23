json.extract! room, :id, :hotel_id, :description, :images, :cost_per_night, :created_at, :updated_at
json.url room_url(room, format: :json)
json.images do
  json.array!(room.images) do |image|
    json.id image.id
    json.url url_for(image)
  end
end
