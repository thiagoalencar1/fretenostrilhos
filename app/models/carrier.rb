class Carrier < ApplicationRecord
  enum status: { active: 0, inactive: 3 }
end
