class BudgetsController < ApplicationController

  def new
    @budget = Budget.new
  end
  
  def create
    @budget = Budget.create(budget_params)
    redirect_to '/'
  end

  private

  def budget_params
    params.require(:budget).permit(:budget_amount, :date)
  end
end

