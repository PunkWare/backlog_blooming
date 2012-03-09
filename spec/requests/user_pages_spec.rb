require 'spec_helper'

describe "user_pages" do
  subject { page }
  
  describe "sign up page" do
    let(:page_title) {'Sign up'}
    before { visit signup_path }
    
    it { should have_selector('title',  text: full_title(page_title)) }
    it { should have_selector('h1',     text: page_title) }
  end
end
