json.array!(@locations) do |location|
  json.extract! location, :id, :category, :placename, :address_1, :address_2, :town, :postcode
  json.url location_url(location, format: :json)
end
