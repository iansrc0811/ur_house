# == Schema Information
#
# Table name: residences
#
#  id          :bigint           not null, primary key
#  address     :string           not null
#  mrt         :string
#  price       :integer          not null
#  room_number :integer          not null
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  city_id     :bigint           not null
#  district_id :bigint           not null
#
# Indexes
#
#  index_residences_on_city_id      (city_id)
#  index_residences_on_district_id  (district_id)
#
# Foreign Keys
#
#  fk_rails_...  (city_id => cities.id)
#  fk_rails_...  (district_id => districts.id)
#
FactoryBot.define do
  factory :residence do
    city
    district
    address {Faker::Address.street_address }
    room_number { 1 }
    mrt { Faker::Name.name }
    title { Faker::Quote.famous_last_words }
    price { 10001 }
    trait :taipei do
      city { create(:city, :taipei) }
    end
  end
end
