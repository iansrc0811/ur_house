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
class Residence < ApplicationRecord
  belongs_to :city
  belongs_to :district

  scope :pagination, -> (page=1, per_page=25) {
    order("id desc").page(page).per(per_page)
  }

  def self.filter_by(city_id:, district_id:, room_number:, price_min:, price_max:, mrt:)
    if price_min.present? && price_max.present? && price_min > price_max
      raise ArgumentError, "price_min must be less than price_max"
    end
    result = all
    if city_id.present?
      result = where("city_id = ?", city_id)
    end
    if district_id.present?
      result = result.where("district_id = ?", district_id)
    end
    if room_number.present?
      result = result.where("room_number = ?", room_number.to_i)
    end
    if price_min.present? && price_max.present?
      result = result.where("price >= ? And price < ?", price_min, price_max)
    end
    if mrt.present?
      result = result.where("mrt = ?", mrt)
    end
    result
  end

  def self.list(city_id:, district_id:, room_number:, price_min:, price_max:, mrt:, page: ,per_page:)
    items =
      includes(:city, :district)
      .filter_by(
        city_id: city_id,
        district_id: district_id,
        room_number: room_number,
        price_min: price_min,
        price_max: price_max,
        mrt: mrt)
      .pagination(page, per_page)
      .as_json(
        only:[
          :id,
          :address,
          :mrt,
          :price,
          :room_number,
          :title
        ],
        include: {
          city: { only: [:id, :name] },
          district: { only: [:id, :name] }
          }
      )

      {
        items: items,
        page: page,
        per_page: per_page,
        total: self.count
      }
  end
end
