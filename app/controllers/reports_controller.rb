class ReportsController < ApplicationController
  def index
    @incomes = Income.all
    @expenses = Expense.all
    today = Date.today
    @budgets = Budget.all
    @today_budget = Budget.where(date: Date.today).pluck(:budget_amount).first

    # 今日の日付の支出の合計を計算
    @total_expense_amount_today = Expense.where(date: today).sum(:expense_amount)
  end

  def create
  end
end
