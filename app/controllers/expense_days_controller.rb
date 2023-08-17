class ExpenseDaysController < ApplicationController
  def new
    @expenseday = ExpenseDay.new
  end

  def create
    @expenseday = ExpenseDay.new(expenseday_params)
    user_selected_days = expenseday_params[:selected_days].to_i  # 選択された日数

    if @expenseday.save
      total_expense_amount = @expenseday.expense_amount
      expense_per_day = (total_expense_amount / user_selected_days).round

      user_selected_days.times do |day_offset|
        date = @expenseday.date + day_offset.days
        ExpenseDay.create(date:, expense_amount: expense_per_day)
      end

      redirect_to '/'
    else
      flash.now[:error] = '支出データの作成に失敗しました。'
      render :new
    end
  end

  private

  def expenseday_params
    params.require(:expense_day).permit(:expense_amount, :date, :selected_days)
  end
end
