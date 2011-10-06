module UsersHelper

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
  
  def authenticate
    deny_access unless signed_in?
  end

end
