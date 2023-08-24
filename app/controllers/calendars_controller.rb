class CalendarsController < ApplicationController
  def index
    today = Date.today
    date = ExpenseDay.first&.date || Date.today
    
   # 日々の支出
@expense_data = Expense.group(:date).sum(:expense_amount)
@expenses = @expense_data[today] || 0
@expenses_all = Expense.sum(:expense_amount) + ExpenseDay.sum(:expense_amount)
@budgets_all = Budget.sum(:budget_amount)
@differents = @budgets_all - @expenses_all

# 日割りした支出
@expense_per_day = calculate_expense_per_day
@per_day = @expense_per_day[today] || 0

# 予算
@budget = calculate_budget_per_day
@budget_per_day = @budget[date] || 0

@budget_difference = @budget_per_day - (@per_day + @expenses)

# 今月の最初の日付と最後の日付を計算
first_day_of_month = Date.today.beginning_of_month
last_day_of_month = Date.today.end_of_month
days_remaining = last_day_of_month.day - today.day + 1  # 当日も含むように修正

# 当日からの日割り予算を計算し加算
@differents_per_day = @differents / days_remaining.to_f

(first_day_of_month..last_day_of_month).each do |target_day|
  if target_day >= today
    @budget[target_day] = @differents_per_day.to_i
  else
    @budget[target_day] = 0
  end
end

  
    
    
  end

  private

  def calculate_expense_per_day
    expense_data = ExpenseDay.all
    expense_per_day = {}

    expense_data.each do |expense|
      date = expense.date
      amount = expense.expense_amount
      select_day = expense.selected_days || 1

      daily_expense = select_day > 0 ? amount.to_i / select_day : 0

      (0...select_day).each do |i|
        target_date = date + i.days
        expense_per_day[target_date] ||= 0
        expense_per_day[target_date] += daily_expense
      end
    end

    expense_per_day
  end

  def calculate_budget_per_day
    budget_data = Budget.group(:date).sum(:budget_amount)
    budget_per_day = {}

    registered_dates = budget_data.keys

    if registered_dates.any?
      last_day_of_month = Date.today.end_of_month.day

      registered_dates.each do |date|
        amount = budget_data[date]
        days_remaining = last_day_of_month - date.day + 1
        per_day = amount / days_remaining # 整数の除算を行う

        # 登録日を含むように日割りを設定
        (0..days_remaining - 1).each do |offset|
          target_date = date + offset.days
          budget_per_day[target_date] ||= 0
          budget_per_day[target_date] += per_day
        end
      end
    end

    budget_per_day
  end
  
end
