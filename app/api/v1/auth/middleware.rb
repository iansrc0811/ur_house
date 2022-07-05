module V1
  module Auth
    class Middleware < Grape::Middleware::Base
      def before
        if token.present?
          # to get current_user, see app/api/auth_helpers.rb
          @env["api_v1_user"] ||=  Warden::JWTAuth::UserDecoder.new.call(token, :user, nil)
        end
      rescue Warden::JWTAuth::Errors::RevokedToken => e
        raise AuthorizationError, e.message
      end

      def request
        @request ||= ::Grape::Request.new(env)
      end

      def token
        return nil if request.headers["Authorization"].blank?

        @token = request.headers["Authorization"].gsub("Bearer ", "")
      end

      def params
        @params ||= request.params
      end
    end
  end
end
