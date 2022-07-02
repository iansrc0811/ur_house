module V1
  module Auth
    class Middleware < Grape::Middleware::Base
      def before
        if token.present?
          # to get current_user, see app/api/auth_helpers.rb
          @env["api_v1_user"] ||=  Warden::JWTAuth::UserDecoder.new.call(token, :user, nil)
        end
      end

      def request
        @request ||= ::Grape::Request.new(env)
      end

      def token
        @token = params[:jwt]
      end

      def params
        @params ||= request.params
      end
    end
  end
end