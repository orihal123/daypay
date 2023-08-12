class Expense < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category2

  validates :expense_amount, :date, :category2_id, presence: true
end
