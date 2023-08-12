class ReportsController < ApplicationController
  def index
    @incomes = Income.all
    @expenses = Expense.all
    today = Date.today

    # 今日の日付の支出の合計を計算
    @total_expense_amount_today = Expense.where(date: today).sum(:expense_amount)

  end

  def create
  end
end
