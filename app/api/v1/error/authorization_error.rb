module V1
  module Error
    class AuthorizationError < BaseError
      def initialize(text = nil)
        super(text: (text || 'Authorization failed'), status: 401)
      end
    end
  end
end
