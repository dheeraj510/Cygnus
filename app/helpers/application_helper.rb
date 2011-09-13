module ApplicationHelper
  def logo
    image_tag("logo.png", :alt => "Cygnus", :class => "round")
  end
   
  def title
    base_title = "Cygnus"
      
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

end
