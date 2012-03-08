require 'spec_helper'

describe "info_pages" do
  subject { page }
  
  describe "home page" do
    before { visit root_path }
    
    it { should have_selector('title', :text => full_title('Home')) }
    it { should have_selector('h1', :text => 'Backlog Blooming') }
  end
  
  describe "help page" do
    let(:page_title) {'Help'}
    before { visit help_path }
    
    it { should have_selector('title', :text => full_title(page_title)) }   
    it { should have_selector('h1', :text => page_title) }
  end
  
  describe "about page" do
    let(:page_title) {'About'}
    before { visit about_path }
    
    it { should have_selector('title', :text => full_title(page_title)) }
    it { should have_selector('h1', :text => page_title) }
  end
  
end
