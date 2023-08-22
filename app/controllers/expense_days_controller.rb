class ExpenseDaysController < ApplicationController
  def new
    @expenseday = ExpenseDay.new
  end

  def create
    @expense = ExpenseDay.create(expenseday_params)
    redirect_to '/'
  end

  private

  def expenseday_params
    params.require(:expense_day).permit(:expense_amount, :date, :selected_days)
  end
end
