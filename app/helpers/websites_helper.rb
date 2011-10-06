module WebsitesHelper

  def website_admin
    redirect_to(root_path) unless current_website.admin?(current_user)
  end

end
