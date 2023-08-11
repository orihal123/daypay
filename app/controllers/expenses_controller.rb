class ExpensesController < ApplicationController

  def new
    @expense = Expense.new
  end
  
  def create
    @expense = Expense.create(expense_params)
    redirect_to '/'
  end

  private

  def expense_params
    params.require(:expense).permit(:expense_amount, :date, :category_id)
  end
end
