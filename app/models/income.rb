class Income < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  

   validates :income_amount, :date, :category_id, presence: true
end
