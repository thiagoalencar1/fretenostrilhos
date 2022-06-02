class Vehicle < ApplicationRecord
  belongs_to :carrier, optional: true

  validates :model, :brand, :year, :license_plate, presence: true
end
