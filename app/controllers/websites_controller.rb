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

  def edit
    @website = Website.find(params[:id])
    @title = "Edit Web Site"
  end

  def update
    @website = Website.find(params[:id])
    if @website.update_attributes(params[:website])
      flash[:success] = "Web site updated."
      redirect_to @website
    else
      @title = "Edit Web Site"
      render 'edit'
    end
  end


end
