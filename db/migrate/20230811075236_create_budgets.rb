class CreateBudgets < ActiveRecord::Migration[7.0]
  def change
    create_table :budgets do |t|
      t.integer      :budget_amount,             null: false
      t.date         :date,                      null: false

      t.timestamps
    end
  end
end
