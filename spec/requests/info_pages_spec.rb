require 'spec_helper'

describe "info_pages" do
  subject { page }
  
  shared_examples_for "all static pages" do
    it { should have_title(full_title(page_title)) }   
    it { should have_heading(heading) }
  end
  
  let(:home_page_title) {"Home"}
  let(:about_page_title) {"About"}
  let(:help_page_title) {"Help"}
  
  describe "home page" do
    before { visit root_path }
    let(:page_title) {home_page_title}
    let(:heading) {'Backlog Blooming'}  
    
    it_should_behave_like "all static pages"
  end
  
  describe "help page" do
    before { visit help_path }
    let(:page_title) {help_page_title}
    let(:heading) {help_page_title} 
    
    it_should_behave_like "all static pages"
  end
  
  describe "about page" do
    before { visit about_path }
    let(:page_title) {about_page_title}
    let(:heading) {about_page_title}  
      
    it_should_behave_like "all static pages"
  end
  

  it "should have the right links on the layout" do
    visit root_path
    
    click_link "About"
    page.should have_title(full_title(about_page_title))
    
    click_link "Help"
    page.should have_title(full_title(help_page_title))
    
    click_link "Home"
    page.should have_title(full_title(home_page_title))
    
    click_link "Sign up now!"
    page.should have_title(full_title('Sign up'))
    
  end
  
end
