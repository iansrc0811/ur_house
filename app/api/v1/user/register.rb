module V1
  module User
    class Register < Grape::API
      namespace :user do
        namespace :register do
          before do
            @user_auth_service = UserAuthService.new(email: params[:email], password: params[:password])
          end

          # set response headers
          after do
            header 'Authorization', "Bearer #{@user_auth_service.jwt}"
          end

          desc "Create an new user"

          params do
            requires :email, type: String, desc: 'User email'
            requires :password, type: String, desc: 'User password'
          end

          post do
            user = @user_auth_service.register
            present user, with: V1::Entities::User
          end
        end
      end
    end
  end
end
