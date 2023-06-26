json.extract! course, :id, :title, :description, :registration_fee, :created_at, :updated_at
json.url course_url(course, format: :json)
