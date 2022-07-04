# == Schema Information
#
# Table name: favorite_lists
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  residence_id :bigint           not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_favorite_lists_on_residence_id  (residence_id)
#  index_favorite_lists_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (residence_id => residences.id)
#  fk_rails_...  (user_id => users.id)
#
class FavoriteList < ApplicationRecord
  belongs_to :user
  belongs_to :residence
end
