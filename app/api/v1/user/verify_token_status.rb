module V1
  module User
    class VerifyTokenStatus < Grape::API
      namespace :user do
        namespace :verify_token_status do
          before do
            authenticate!
          end

          desc "verify if token is still valid"

          get do
            user = UserAuthService.new.verify(current_user)
            present user, with: V1::Entities::User
          end
        end
      end
    end
  end
end
