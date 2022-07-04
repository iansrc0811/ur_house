# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  admin                  :boolean          default(FALSE), not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  jti                    :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_admin                 (admin)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_jti                   (jti) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :jwt_authenticatable, jwt_revocation_strategy: self

  scope :admins, -> { where(admin: true) }

  has_many :favorite_lists, dependent: :destroy
  has_many :residences, through: :favorite_lists

  def admin?
    admin
  end

  def admin!
    update!(admin: true)
  end

  def jwt_payload
    super.merge("is_admin"=> admin)
  end

  def self.register(email:, password:)
    raise "No email or password" if email.blank? || password.blank?
    raise "User Exist" if User.find_by_email(email)

    create!(email: email, password: password)
  end
end
