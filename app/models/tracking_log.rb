class TrackingLog < ApplicationRecord
  belongs_to :order
  before_validation :set_when
  validates :what, :when, :where, presence: true
  validates :when, comparison: { greater_than: DateTime.yesterday, message: 'não pode ser pretérita' }

  def set_when
    self.when ||= DateTime.current.to_date
  end
end
