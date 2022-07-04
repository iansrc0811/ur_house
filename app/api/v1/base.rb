module V1
  class Base < Grape::API
    include ExceptionHandler
    version 'v1', using: :path
    use V1::Auth::Middleware

    mount V1::User::Register
    mount V1::User::Login
    mount V1::User::Logout

    mount V1::Residences::Index
    mount V1::Residences::Delete
    mount V1::Residences::Edit

    mount V1::FavoriteList::Index
  end
end
