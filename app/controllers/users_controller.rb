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
      sign_in @user
      flash[:success] = "New user has been added"
      redirect_to @user
    else
      @title = "Add new user"
      render 'new'
    end
  end
 
  def edit
    @user = User.find(params[:id])
    @title = "Edit user"
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end

end
