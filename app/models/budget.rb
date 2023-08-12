class Budget < ApplicationRecord
  validates :budget_amount, :date, presence: true

  belongs_to :report
end
