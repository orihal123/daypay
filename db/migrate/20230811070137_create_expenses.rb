class CreateExpenses < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses do |t|
      t.integer      :expense_amount,               null: false
      t.date        :date,                       null: false
      t.integer     :category_id,                 null: false

      t.timestamps
    end
  end
end
