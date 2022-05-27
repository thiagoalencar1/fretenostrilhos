class Order < ApplicationRecord
  belongs_to :carrier

  validates :distance, :carrier_id, presence: true

  before_validation :generate_order_number

  private

  def generate_order_number
    self.order_number = SecureRandom.alphanumeric(8).upcase
  end
end
