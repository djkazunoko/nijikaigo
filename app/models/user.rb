class User < ApplicationRecord
  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: { scope: :provider }
  validates :name, presence: true, uniqueness: true
  validates :image_url, presence: true, uniqueness: true
end
