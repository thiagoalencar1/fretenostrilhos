class Carrier < ApplicationRecord
  enum status: { active: 0, inactive: 3 }

  validates :brand_name, :corporate_name, :email_domain, :taxpayer_number, :status, presence: true
end
