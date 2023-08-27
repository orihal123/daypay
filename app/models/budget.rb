class Budget < ApplicationRecord
  validates :budget_amount, :date, presence: true

end
