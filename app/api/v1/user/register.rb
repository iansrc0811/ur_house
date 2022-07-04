module V1
  module User
    class Register < Grape::API
      namespace :user do
        namespace :register do
          before do
            @user_auth_service = UserAuthService.new(email: params[:email], password: params[:password], first_name: params[:first_name], last_name: params[:last_name])
          end

          # set response headers
          after do
            header 'Authorization', "Bearer #{@user_auth_service.jwt}"
          end

          desc "Create an new user"

          params do
            requires :first_name, type: String, desc: 'User first name'
            requires :last_name, type: String, desc: 'User last name'
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
