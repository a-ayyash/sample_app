module ApplicationHelper
  def logo
    "logo.png"
  end
  
  def title
    base_title = "Ruby On Rails Tutorials Sample App"
    if @title.nil? 
      base_title
    else
      "#{base_title} | #{@title}"
    end
    
  end
end
