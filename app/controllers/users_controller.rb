class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update, :create, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :website_admin,   :only => [:create, :destroy]

  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find(params[:id])
    @title = @user.email
  end

  def new
    @user = User.new
    @title = "Add new user"
  end
 
  def create
    # Only website admin (see filter) can create a new user and all users they create belong to the same website the admin belongs to
    @website = Website.find (current_user.website_id)
    @user = @website.users.new(params[:user])
    
    if @user.save
      sign_in @user #!!! SHOULD NOT DO THIS
      flash[:success] = "New user has been added"
      redirect_to @user
    else
      @title = "Add new user"
      render 'new'
    end
  end
 
  def edit
    @title = "Edit user"
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

end
