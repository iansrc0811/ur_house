module V1
  module Entities
    class Residence < Entities::Base
      # https://github.com/ruby-grape/grape-entity#basic-exposure
      # make entity read stringyfied keys (default is symbol)
      self.hash_access = :to_s

      expose :id
      expose :title
      expose :price
      expose :city, using: V1::Entities::City
      expose :district, using: V1::Entities::District
      expose :room_number
      expose :mrt
    end
  end
end
