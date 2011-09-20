class WebsitesController < ApplicationController
  
  def show
    @website =Website.find(params[:id])
    @title = @website.title
  end

  def new
    @title = "Add a new web site"
  end

end
