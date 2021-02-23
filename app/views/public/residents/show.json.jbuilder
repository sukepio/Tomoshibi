json.array!(@myevents) do |event|
  json.extract! event, :id, :title, :body
  json.start event.start
  json.url edit_myevent_url(event, format: :html)
end
