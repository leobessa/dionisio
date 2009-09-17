# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper        
  def rating_tag(value) 
    return unless value                                  
    options = {:class => "current-rating", :style => "width:#{30*value}px;"}
    content_tag(:li, "Currently #{value}/5 Stars", options)
  end
end
