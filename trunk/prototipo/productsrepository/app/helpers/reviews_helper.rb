module ReviewsHelper       
  
  def rating_tag(value) 
    return unless value                                  
    options = {:class => "current-rating", :style => "width:#{30*value}px;"}
    content_tag(:li, "Currently #{value}/5 Stars", options)
  end
             
  def link_to_new_review(product,rating)   
    classes = ["one-star","two-stars","three-stars","four-stars","five-stars"]
    link_to "#{rating}", 
	  url_for(:controller=>'reviews', :action=>'new', 
	  :review => {:rating => rating}, :product_id => product),
	  :class => classes[rating-1], :title => "#{rating} star#{rating == 1 ? '' : 's'} out of 5"
  end
  
end
