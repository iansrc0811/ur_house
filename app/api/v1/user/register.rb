module V1
  module User
    class Register < Grape::API
      namespace :user do
        namespace :register do
          before do
            @user_registration_service = UserRegistrationService.new(email: params[:email], password: params[:password])
          end

          # set response headers
          after do
            header 'Authorization', @user_registration_service.token
          end

          post do
            @user_registration_service.register
          end
        end
      end
    end
  end
end
