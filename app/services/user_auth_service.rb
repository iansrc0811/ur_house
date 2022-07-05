class UserAuthService
  attr_reader :email, :password, :first_name, :last_name, :jwt

  def initialize(email: nil, password: nil, first_name: nil, last_name: nil, user_id: nil)
    @email = email
    @password = password
    @first_name = first_name
    @last_name = last_name
    @user_id = user_id
  end

  def register
    check_params
    raise AuthorizationError, "User Already Exists" if User.find_by_email(email)

    user = User.create!(email: email, password: password, first_name: first_name, last_name: last_name)
    @jwt, payload = Warden::JWTAuth::UserEncoder.new.call(user, :user, nil)
    user_formater(user)
  end

  def login
    check_params
    user = User.find_by_email(email)
    raise AuthorizationError, "Invalid Email" if user.blank?

    raise AuthorizationError, "Invalid Password" if !user.valid_password?(password)

    @jwt, payload = Warden::JWTAuth::UserEncoder.new.call(user, :user, nil)
    user_formater(user)
  end

  def logout
    User.revoke_jwt(nil, User.find(@user_id))
  end

  def verify(user)
    @jwt, payload = Warden::JWTAuth::UserEncoder.new.call(user, :user, nil)
    user_formater(user)
  end

  private

  def user_formater(user)
    user.as_json(
      except: [:created_at, :updated_at, :jti],
      methods: :full_name).merge("jwt"=> @jwt)
  end

  def check_params
    raise ParamMissingError, "No email or password provided" if email.blank? || password.blank?
  end
end
