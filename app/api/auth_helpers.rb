module AuthHelpers
  def current_user
    @current_user ||= env["api_v1_user"]
  end

  def authenticate!
    raise AuthorizationError if current_user.blank?
  end
end
