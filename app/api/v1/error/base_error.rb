module V1
  module Error
    class BaseError < Grape::Exceptions::Base
      attr :text, :status, :message

      def initialize(opts={})
        @text    = opts[:text]   || ''

        @status  = opts[:status] || 400
        @message = { error: { code: @code, message: @text } }
      end
    end
  end
end
