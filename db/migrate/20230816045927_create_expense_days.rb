class CreateExpenseDays < ActiveRecord::Migration[7.0]
  def change
    create_table :expense_days do |t|
      t.integer     :expense_amount,               null: false
      t.date        :date,                         null: false

      t.integer      :selected_days, null: false, default: 0

      t.timestamps
    end
  end
end

