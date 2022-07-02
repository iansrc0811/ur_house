module V1
  module User
    class Login < Grape::API
      namespace :user do
        namespace :login do
          before do
            @user_auth_service = UserAuthService.new(email: params[:email], password: params[:password])
            @token =  @user_auth_service.token
          end

          # set response headers
          after do
            header 'Authorization Bearer', @user_auth_service.token
          end

          post do
            user = @user_auth_service.login
            present user, with: V1::Entities::User
          end
        end
      end
    end
  end
end
