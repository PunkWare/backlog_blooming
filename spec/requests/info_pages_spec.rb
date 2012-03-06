require 'spec_helper'

describe "info_pages" do
  describe "home page" do
    it "should have the content 'Backlog Blooming | Home'" do
      visit '/info_pages/home'
      page.should have_content('Backlog Blooming | Home')
    end
  end
  
  describe "help page" do
    it "should have the content 'Backlog Blooming | Help'" do
      visit '/info_pages/help'
      page.should have_content('Backlog Blooming | Help')
    end
  end
  
  describe "about page" do
    it "should have the content 'Backlog Blooming | About'" do
      visit '/info_pages/about'
      page.should have_content('Backlog Blooming | About')
    end
  end
end
