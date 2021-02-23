json.array!(@meals) do |event|
  json.id "#{event.id}"
  json.title "#{event.menu}"
  json.start event.start
  json.url edit_meal_url(event, format: :html)
end
