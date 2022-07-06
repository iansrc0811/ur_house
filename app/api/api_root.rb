class ApiRoot < Grape::API
  PREFIX = '/api'.freeze

  format :json

  helpers AuthHelpers

  mount V1::Base
end
