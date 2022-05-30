class Order < ApplicationRecord
  belongs_to :carrier
  has_many :tracking_logs
  before_create :generate_order_number

  enum status: { pending: 0, accepted: 3, delivered: 6, rejected: 9 }

  validates :package_weight, :package_volume, :distance, :origin_address, :destiny_address, :order_value,
            :delivery_date, presence: true
  validates :package_weight, :package_volume, :distance, numericality: true

  private

  def generate_order_number
    self.order_number = SecureRandom.alphanumeric(15).upcase
  end
end
