class UserAuthService
  attr_reader :email, :password, :token

  def initialize(email: nil, password: nil, user_id: nil)
    raise ParamMissingError, "No email or password provided" if email.blank? || password.blank?


    @email = email
    @password = password
    @user_id = user_id
  end

  def register
    raise AuthorizationError, "User Already Exists" if User.find_by_email(email)

    user = User.create!(email: email, password: password)
    @token, payload = Warden::JWTAuth::UserEncoder.new.call(user, :user, nil)
    user
  end

  def login
    user = User.find_by_email(email)
    raise AuthorizationError, "Invalid Email" if user.blank?

    raise AuthorizationError, "Invalid Password" if !user.valid_password?(password)

    @token, payload = Warden::JWTAuth::UserEncoder.new.call(user, :user, nil)
    user
  end
end
