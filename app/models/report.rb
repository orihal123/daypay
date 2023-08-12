class Report < ApplicationRecord
  has_many :incomes
  has_many :expenses
  has_many :budgets

  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to_active_hash :category
  belongs_to_active_hash :category2
end
