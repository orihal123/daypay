class ExpenseDay < ApplicationRecord
  validates :expense_amount, :date, presence: true
end
