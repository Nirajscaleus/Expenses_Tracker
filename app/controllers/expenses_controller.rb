class ExpensesController < ApplicationController
  def index
    if session[:user_id]
      @user = User.find_by(id: session[:user_id])
      @expenses = @user.expenses if @user
    else
      @expenses = Expense.all
    end
  end
  
  def new
    @expense = Expense.new
  end
  def show
    @expense = Expense.find(params[:id])
  end
  def create
    @expense = Expense.new(expense_params)
    if @expense.save
      redirect_to @expense, notice: 'Expense was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end
  def edit
    @expense = Expense.find(params[:id])
  end

  def update
    @expense = Expense.find(params[:id])
    if @expense.update(expense_params)
      redirect_to @expense
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy

    redirect_to root_path, status: :see_other
  end

  private
  def expense_params
    params.require(:expense).permit(:title,:description,:date, :user_id)
  end
end
