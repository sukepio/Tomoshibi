json.array!(@meals) do |event|
  json.extract! event, :id, :menu, :amount, :detail
  json.start event.start
  json.url edit_admin_meal_url(event, format: :html)
end