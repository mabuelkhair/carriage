class AuthenticateUser
  prepend SimpleCommand

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    user_obj = user
    if user_obj
      expiration_time = 1.week.from_now
      token = JsonWebToken.encode(user_id: user_obj.id,role: user_obj.role)
      user_obj.update_attribute(:token,token)
      $redis.set("user:#{user_obj.id}", token, options = {ex: expiration_time.to_i - Time.now.to_i})
    end
    token
  end

  private

  attr_accessor :email, :password

  def user
    user = User.find_by_email(email)
    return user if user && user.authenticate(password)

    errors.add :user_authentication, 'invalid credentials'
    nil
  end
end