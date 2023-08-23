require_relative '../../config/environment'

task :save_budget_difference => :environment do
  today = Date.today
  date = ExpenseDay.first&.date || Date.today

  expense_data = Expense.group(:date).sum(:expense_amount)
  expenses = expense_data[today] || 0

  expense_per_day = BudgetCalculator.calculate_expense_per_day
  per_day = expense_per_day[today] || 0

  budget = BudgetCalculator.calculate_budget_per_day
  budget_per_day = budget[date] || 0

  budget_difference = budget_per_day - (per_day + expenses)

  puts "Calculated budget difference: #{budget_difference}"

  if budget_difference != 0
    budget_diff_record = BudgetDifference.new(
      budgetdifferences_amount: budget_difference,
      date: today # 今日の日付を指定
    )

    if budget_diff_record.save
      puts "Budget difference saved: #{budget_difference}"
    else
      puts "Budget difference not saved"
      puts budget_diff_record.errors.full_messages
    end
  else
    puts "Budget difference is 0, no need to save"
  end
end
