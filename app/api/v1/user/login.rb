module V1
  module User
    class Login < Grape::API
      namespace :user do
        namespace :login do
          before do
            @user_auth_service = UserAuthService.new(email: params[:email], password: params[:password])
          end

          # set response headers
          after do
            header 'Authorization Bearer', @user_auth_service.token
          end

          post do
            @user_auth_service.login
          end
        end
      end
    end
  end
end
