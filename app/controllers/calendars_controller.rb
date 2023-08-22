class CalendarsController < ApplicationController
  def index
    #日々の支出を表示
    @expense_data = Expense.group(:date).sum(:expense_amount)
    #その他項目の日割りを表示
    @expense_per_day = calculate_expense_per_day
    # 予算の表示
    @budget = calculate_budget_per_day
  end

  private

  
  def calculate_expense_per_day
    expense_data = ExpenseDay.all
    expense_per_day = {}
  
    expense_data.each do |expense|
      date = expense.date
      amount = expense.expense_amount
      select_day = expense.selected_days || 1  # もしselected_daysがnilの場合、デフォルトで1とします
  
      daily_expense = amount.to_i / select_day 
  
      (0...select_day).each do |i|
        target_date = date + i.days
        expense_per_day[target_date] ||= []
        expense_per_day[target_date] << daily_expense  # 日付ごとの配列に追加
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
        per_day = amount / days_remaining  # 整数の除算を行う

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