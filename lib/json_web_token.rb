class JsonWebToken
 class << self
   def encode(payload, exp = 1.week.from_now)
     payload[:exp] = exp.to_i
     JWT.encode(payload, ENV['RAILS_SECRET'])
   end

   def decode(token)
     body = JWT.decode(token, ENV['RAILS_SECRET'])[0]
     HashWithIndifferentAccess.new body
   rescue
     nil
   end
 end
end