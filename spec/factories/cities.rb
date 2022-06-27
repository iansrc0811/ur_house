# == Schema Information
#
# Table name: cities
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :city do
    name { "city" }
    trait :taipei do
      name { "Taipei City" }
    end

    trait :new_taipei do
      name { "New Taipei City"}
    end
  end
end
