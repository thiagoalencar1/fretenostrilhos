class Carrier < ApplicationRecord
  has_many :users
  has_many :distance_prices
  has_many :price_ranges, through: :distance_prices

  enum status: { active: 0, inactive: 3 }

  validates :brand_name, :corporate_name, :email_domain, :taxpayer_number, presence: true
  validates :taxpayer_number, length: { is: 14, message: 'deve ter 14 digitos.' }
  validates :taxpayer_number, numericality: true
  validates :taxpayer_number, :email_domain, uniqueness: true
end
