module V1
  module Entities
    class User < Entities::Base
      # https://github.com/ruby-grape/grape-entity#basic-exposure
      # make entity read stringyfied keys (default is symbol)
      self.hash_access = :to_s

      expose "id"
      expose "email"
      expose "amin"
      expose "jwt"
    end
  end
end
