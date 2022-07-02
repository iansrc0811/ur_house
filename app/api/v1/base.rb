module V1
  class Base < Grape::API
    include ExceptionHandler
    version 'v1', using: :path
    use V1::Auth::Middleware

    mount V1::User::Register
    mount V1::User::Login
    mount V1::User::Logout
  end
end
