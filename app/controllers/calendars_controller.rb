class CalendarsController < ApplicationController
  def index
    today = Date.today

    # 今日の支出の合計を計算
    @total_expense_amount_today = Expense.where(date: today).sum(:expense_amount)

    @expenses = Expense.where(date: today)
    # カレンダー表示のための日付と支出データを用意
    @calendar_data = {}
    @calendar_budgets = {}

    @expense_per_day = 0 if @expense_per_day.nil?
   

    # 支出データを日付ごとに合計してカレンダーにセット
    Expense.where(date: today.beginning_of_month..today.end_of_month).group(:date).sum(:expense_amount).each do |date, expense_amount|
      @calendar_data[date] = expense_amount || 0
    end

    (today.beginning_of_month..today.end_of_month).each do |date|
      @calendar_data[date] ||= 0
    end

    # 予算の登録日から月末まで登録額を等分して表示
    @budgets = Budget.where(date: today.beginning_of_month..today.end_of_month)
    if @budgets.present?
      total_budget = @budgets.sum(:budget_amount)
      days_in_month = (today.end_of_month.day - @budgets.first.date.day + 1)
      budget_per_day = (total_budget.to_f / days_in_month).to_i # 小数点以下を切り捨て
      @budget_per_day = budget_per_day
      # 予算の登録日以前の日は０、登録日から月末まで等分して表示
      (today.beginning_of_month..today.end_of_month).each do |date|
        @calendar_budgets[date] = if date < @budgets.first.date
                                    0
                                  else
                                    budget_per_day
                                  end
      end
    else
      # 予算が登録されていない場合、全ての日に0を設定
      (today.beginning_of_month..today.end_of_month).each do |date|
        @calendar_budgets[date] = 0
      end
    end


    @expensedays = ExpenseDay.where(date: Date.today)
    @calendar_daydata = {}

    @expensedays.each do |expenseday|
      next unless expenseday.selected_days > 0

      total_expense_amount = expenseday.expense_amount
      expense_per_day = (total_expense_amount / expenseday.selected_days).round

      (expenseday.date..expenseday.date + expenseday.selected_days - 1).each do |date|
        @calendar_daydata[date] ||= 0 # 既にデータがある場合は上書きしないようにする
        @calendar_daydata[date] += expense_per_day
        @expense_per_day = expense_per_day
      end
    end
    
    @budget_differents = @budget_per_day - (@expense_per_day + @total_expense_amount_today)

    # 予算の変動に応じてカレンダーの予算を更新
    days_remaining = (today.end_of_month - today).to_i
    daily_budget_change = (@budget_differents / days_remaining.to_f).to_i
    (today + 1.day..today.end_of_month).each do |date|
      @calendar_budgets[date] = [@calendar_budgets[date] + daily_budget_change, 0].max
    end
  end

  private

  def calculate_budgets(date)
    @budgets = Budget.where(date: date.beginning_of_month..date.end_of_month)
    if @budgets.present?
      total_budget = @budgets.sum(:budget_amount)
      days_in_month = (date.end_of_month - date.beginning_of_month).to_i + 1
      @budget_per_day = (total_budget.to_f / days_in_month).to_i
      
      @calendar_budgets = {}
      (date.beginning_of_month..date.end_of_month).each do |d|
        if d < date # 今日以前の日は前日の予算を使う
          @calendar_budgets[d] = d < @budgets.first.date ? 0 : @budget_per_day
        else # 今日以降の日は今日の予算を使う
          @calendar_budgets[d] = @budget_per_day
        end
      end
    else
      @calendar_budgets = {}
      (date.beginning_of_month..date.end_of_month).each do |d|
        @calendar_budgets[d] = 0
      end
    end
  end
end
