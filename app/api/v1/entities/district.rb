module V1
  module Entities
    class District < Entities::Base
      self.hash_access = :to_s
      expose :id
      expose :name
    end
  end
end
