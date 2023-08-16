class ExpenseDaysController < ApplicationController
  def new
    @expenseday = ExpenseDay.new
  end

  def create
    @expenseday = ExpenseDay.create(expenseday_params)
    redirect_to '/'
  end

  private

  def expenseday_params
    params.require(:expense_day).permit(:expense_amount, :date)
  end
end
