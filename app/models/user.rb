class User < ApplicationRecord
  belongs_to :carrier
  before_validation :set_carrier
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  private

  def set_carrier
    available_domains = Carrier.where(status: 'active').map(&:email_domain)
    user_domain = email.split('@').last
    self.carrier_id = Carrier.find_by(email_domain: user_domain).id if available_domains.include?(user_domain)
  end
end
