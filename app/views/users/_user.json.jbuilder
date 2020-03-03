json.extract! user, :id, :last_name, :name, :balance, :created_at, :updated_at
json.url user_url(user, format: :json)
