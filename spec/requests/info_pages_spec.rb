require 'spec_helper'

describe "info_pages" do
  
  let(:base_title) {"Backlog Blooming"}
  
  describe "home page" do
    it "should have the right title" do
      visit root_path
      page.should have_selector('title', :text => "#{base_title} | Home")
    end
      
    it "should have the right h1" do
      visit root_path
      page.should have_selector('h1', :text => 'Backlog Blooming')
    end
  end
  
  describe "help page" do
    it "should have the right title" do
      visit help_path
      page.should have_selector('title', :text => "#{base_title} | Help")
    end
      
    it "should have the right h1" do
      visit help_path
      page.should have_selector('h1', :text => 'Help')
    end
  end
  
  describe "about page" do
    it "should have the right title" do
      visit about_path
      page.should have_selector('title', :text => "#{base_title} | About")
    end
      
    it "should have the right h1" do
      visit about_path
      page.should have_selector('h1', :text => 'About')
    end
  end
  
end
