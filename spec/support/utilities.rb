def full_title(page_title)
  base_title = "Backlog Blooming"
  
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end

RSpec::Matchers.define :have_flash_message do |message, kind|
  match do |page|
    page.should have_selector('div.alert.alert-'+kind, text: message)
  end
end
