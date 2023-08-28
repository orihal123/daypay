class ExpenseDay < ApplicationRecord
  validates :expense_amount, :date, :selected_days, presence: true
end
