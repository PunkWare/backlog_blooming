require 'spec_helper'

describe "info_pages" do
  
  describe "home page" do
    it "should have the right title" do
      visit '/info_pages/home'
      page.should have_selector('title', :text => 'Backlog Blooming | Home')
    end
      
    it "should have the right h1" do
      visit '/info_pages/home'
      page.should have_selector('h1', :text => 'Home')
    end
  end
  
  describe "help page" do
    it "should have the right title" do
      visit '/info_pages/help'
      page.should have_selector('title', :text => 'Backlog Blooming | Help')
    end
      
    it "should have the right h1" do
      visit '/info_pages/help'
      page.should have_selector('h1', :text => 'Help')
    end
  end
  
  describe "about page" do
    it "should have the right title" do
      visit '/info_pages/about'
      page.should have_selector('title', :text => 'Backlog Blooming | About')
    end
      
    it "should have the right h1" do
      visit '/info_pages/about'
      page.should have_selector('h1', :text => 'About')
    end
  end
  
end
