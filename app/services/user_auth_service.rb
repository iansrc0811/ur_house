class UserAuthService
  attr_reader :email, :password, :jwt

  def initialize(email: nil, password: nil, user_id: nil)
    @email = email
    @password = password
    @user_id = user_id
  end

  def register
    check_params
    raise AuthorizationError, "User Already Exists" if User.find_by_email(email)

    user = User.create!(email: email, password: password)
    @jwt, payload = Warden::JWTAuth::UserEncoder.new.call(user, :user, nil)
    user.as_json.merge("jwt"=> @jwt)
  end

  def login
    check_params
    user = User.find_by_email(email)
    raise AuthorizationError, "Invalid Email" if user.blank?

    raise AuthorizationError, "Invalid Password" if !user.valid_password?(password)

    @jwt, payload = Warden::JWTAuth::UserEncoder.new.call(user, :user, nil)
    user.as_json.merge("jwt"=> @jwt)
  end

  def logout
    User.revoke_jwt(nil, User.find(@user_id))
  end

  private

  def check_params
    raise ParamMissingError, "No email or password provided" if email.blank? || password.blank?
  end
end
