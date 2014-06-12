json.array!(@events) do |event|
  json.extract! event, :id, :eventname, :eventdesc, :eventstart, :eventend
  json.url event_url(event, format: :json)
end
