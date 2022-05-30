class TrackingLog < ApplicationRecord
  belongs_to :order
  validates :what, :when, :where, presence: true
end
