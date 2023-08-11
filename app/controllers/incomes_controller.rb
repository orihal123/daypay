class IncomesController < ApplicationController

  def new
    @income = Income.new
  end
  
  def create
    @income = Income.create(income_params)
    redirect_to '/'
  end

  private

  def income_params
    params.require(:income).permit(:income_amount, :date, :category_id)
  end


  
end
