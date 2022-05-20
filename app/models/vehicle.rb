class Vehicle < ApplicationRecord
  belongs_to :carrier

  validates :model, :brand, :year, :license_plate, presence: true
end
