module V1
  module ExceptionHandler
    extend ActiveSupport::Concern
    included do
      rescue_from Grape::Exceptions::ValidationErrors do |e|
        rack_response({
          'message'=> e.message
        }.to_json, e.status)
      end

      rescue_from ActiveRecord::RecordNotFound do
        rack_response({ 'message' => '400 Record Not Found' }.to_json, 400)
      end

      rescue_from AuthorizationError do |e|
        rack_response({ 'message' => e.message }.to_json, 401)
      end

      rescue_from ParamMissingError do |e|
        rack_response({ 'message' => e.message }.to_json, 400)
      end

      route :any, '*path' do
        error!('404 Page Not Found', 404)
      end
    end
  end
end
