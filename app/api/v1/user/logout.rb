module V1
  module User
    class Logout < Grape::API
      namespace :user do
        namespace :logout do
          before do
            authenticate!
            @user_auth_service = UserAuthService.new(user_id: current_user.id)
          end

          desc "Logout user"

          delete do
            @user_auth_service.logout
          end
        end
      end
    end
  end
end
