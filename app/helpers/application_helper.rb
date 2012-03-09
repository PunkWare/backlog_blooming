module ApplicationHelper
  
  #Returns the full title on per-page basis.
  def full_title(page_title)
    base_title = "Backlog Blooming"
    
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
  
  def logo
    image_tag("punkware.jpg", alt: "Backlog Blooming", class: "round")
  end
end
