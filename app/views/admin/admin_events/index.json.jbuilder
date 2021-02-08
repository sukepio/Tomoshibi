json.array!(@admin_events) do |event|
  json.extract! event, :id, :title, :body
  json.start event.start
  json.end event.end
end