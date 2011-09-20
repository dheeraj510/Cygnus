class WebsitesController < ApplicationController
  
  def show
    @website =Website.find(params[:id])
    @title = @website.title
  end

  def new
    @website =Website.new
    @title = "Add a new web site"
  end

  def create
    @website = Website.new(params[:website])

    if (@website.save)
      flash[:success] = "Web site added!"
      redirect_to @website
    else
      @title = "Add a new web site"
      render 'new'
    end
  end
end
