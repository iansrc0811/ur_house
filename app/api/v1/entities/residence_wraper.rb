module V1
  module Entities
    class ResidenceWraper < Entities::Base
      expose :items, using: V1::Entities::Residence
      expose :page
      expose :per_page
      expose :total
    end
  end
end
