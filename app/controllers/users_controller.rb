class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @title = @user.email
  end

  def new
    @user = User.new
    @title = "Add new user"
  end
 
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "New user has been added"
      redirect_to @user
    else
      @title = "Add new user"
      render 'new'
    end
  end

end
