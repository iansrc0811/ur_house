module V1
  class Base < Grape::API
    include ExceptionHandler
    version 'v1', using: :path

    mount V1::User::Register
  end
end
