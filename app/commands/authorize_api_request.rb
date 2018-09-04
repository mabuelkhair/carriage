class AuthorizeApiRequest
  prepend SimpleCommand

  def initialize(headers = {})
    @headers = headers
  end

  def call
    user
  end

  private

  attr_reader :headers

  def user
    if decoded_auth_token
      # if token expired return 
      if @decoded_auth_token[:exp] < Time.now.to_i
        errors.add(:token, 'Token Expired')
        return nil
      end
      # get token from redis
      user_token = $redis.get("user:#{@decoded_auth_token[:user_id]}")
      # check token is exist in cache and set user values
      if user_token
        @user = {'id' => @decoded_auth_token[:user_id], 'role' => @decoded_auth_token[:role]} if user_token == http_auth_header
      else
      # token not in cache so check in database and if exist set in cache
        @user = User.find(@decoded_auth_token[:user_id])
        @user = nil if @user.token != http_auth_header
        $redis.set("user:#{@user.id}",http_auth_header) if @user
      end
    end
    @user || errors.add(:token, 'Invalid token') && nil
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last
    else
      errors.add(:token, 'Missing token')
    end
    nil
  end
end