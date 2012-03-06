require 'spec_helper'

describe "info_pages" do
  describe "home page" do
    it "should have the content 'Backlog Blooming'" do
      visit '/info_pages/home'
      page.should have_content('Backlog Blooming')
    end
  end
  
  describe "help page" do
    it "should have the content 'Backlog Blooming'" do
      visit '/info_pages/help'
      page.should have_content('Backlog Blooming')
    end
  end
end
