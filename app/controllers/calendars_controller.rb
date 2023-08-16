class CalendarsController < ApplicationController
  def index
    today = Date.today

    # 今日の支出の合計を計算
    @total_expense_amount_today = Expense.where(date: today).sum(:expense_amount)
   

    @expenses = Expense.where(date: today)

    # カレンダー表示のための日付と支出データを用意
    @calendar_data = {} 
    @calendar_budgets = {}
    @calendar_daydata = {}

    # 支出データを日付ごとに合計してカレンダーにセット
    Expense.where(date: today.beginning_of_month..today.end_of_month).group(:date).sum(:expense_amount).each do |date, expense_amount|
      @calendar_data[date] = expense_amount
    end

    # 予算の登録日から月末まで登録額を等分して表示
    @budgets = Budget.where(date: today.beginning_of_month..today.end_of_month)
    if @budgets.present?
      total_budget = @budgets.sum(:budget_amount)
      days_in_month = (today.end_of_month.day - @budgets.first.date.day + 1)
      budget_per_day = (total_budget.to_f / days_in_month).to_i  # 小数点以下を切り捨て

      # 予算の登録日以前の日は０、登録日から月末まで等分して表示
      (today.beginning_of_month..today.end_of_month).each do |date|
        if date < @budgets.first.date
          @calendar_budgets[date] = 0
        else
          @calendar_budgets[date] = budget_per_day
        end
      end
    else
      # 予算が登録されていない場合、全ての日に0を設定
      (today.beginning_of_month..today.end_of_month).each do |date|
        @calendar_budgets[date] = 0
      end
    end

    # ExpenseDayのデータを処理してカレンダーに追加
    @expensedays = ExpenseDay.where(date: today..today + 2.days)
    @expensedays.each do |expenseday|
      total_expense_amount = expenseday.expense_amount
      expense_per_day = (total_expense_amount / 3).round
      
      (0..2).each do |day_offset|
        date = expenseday.date + day_offset.days
        @calendar_daydata[date] ||= 0  # 既にデータがある場合は上書きしないようにする
        @calendar_daydata[date] += expense_per_day
      end
    end

    # 登録されていない日には0を設定
    (@expensedays.last.date + 1.day..today + 2.days).each do |date|
      @calendar_daydata[date] ||= 0
    end

    
end

