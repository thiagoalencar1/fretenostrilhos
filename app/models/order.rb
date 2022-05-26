class Order < ApplicationRecord
  belongs_to :carrier

  validates :distance, :carrier_id, presence: true

  before_validation :generate_code

  private

  def generate_code
    self.order_number = SecureRandom.alphanumeric(8).upcase
  end
end
