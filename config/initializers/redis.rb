$redis = Redis.new(url: ENV["REDI_URL"]) if Rails.env.production?