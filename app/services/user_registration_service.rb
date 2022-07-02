class UserRegistrationService
  attr_reader :email, :password, :token

  def initialize(email:, password:)
    raise ParamMissingError, "No email or password provided" if email.blank? || password.blank?

    raise AuthorizationError, "User Already Exists" if User.find_by_email(email)

    @email = email
    @password = password
  end

  def register
    user = User.create!(email: email, password: password)
    @token, payload = Warden::JWTAuth::UserEncoder.new.call(user, :user, nil)
    user
  end
end
