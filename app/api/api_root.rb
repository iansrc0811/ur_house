class ApiRoot < Grape::API
  PREFIX = '/api'.freeze

  format :json

  helpers AuthHelpers
  helpers do
    def unauthorized_error!
      error!('Unauthorized', 401)
    end
  end

  mount V1::Base
end
