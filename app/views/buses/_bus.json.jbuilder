json.extract! bus, :id, :name, :registration_no, :route, :seats, :user_id, :created_at, :updated_at
json.url bus_url(bus, format: :json)
