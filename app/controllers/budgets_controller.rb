class BudgetsController < ApplicationController
  def new
    @budget = Budget.new
  end

  def create
    @budget = Budget.create(budget_params)

    if @budget.save
      redirect_to '/'
    else
      flash.now[:error] = '予算の作成に失敗しました。'
      logger.error @budget.errors.full_messages.join(', ')  # エラーメッセージをログに表示
      render :new
    end
  end

  private

  def budget_params
    params.require(:budget).permit(:date, :budget_amount)
  end
end
