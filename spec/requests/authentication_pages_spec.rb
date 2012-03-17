require 'spec_helper'

describe "Signin, and signout pages" do
  subject { page }
  
  shared_examples_for "all authentication pages" do
    it { should have_selector('title', text: full_title(page_title)) }   
    it { should have_selector('h1',    text: heading) }
  end
  
  describe "When testing title and h1 on sign up page, " do
    before { visit signin_path }
    let(:heading) {'Sign in'}
    let(:page_title) {heading}
    
    it_should_behave_like "all authentication pages"
  end
  
  describe "When providing sign in fields" do
    let(:sign_in_button) {'Sign in'}
    
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button sign_in_button }

      it { should have_flash_message('Invalid email/password combination','error') }
      
      # making sure that the flash message doesn't stay when going to another page
      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end
    
    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      
      before do
        fill_in "Email",    with: user.email
        fill_in "Password", with: user.password
        click_button sign_in_button
      end

      it { should have_selector('title',  text: user.name) }
      it { should have_link('Profile',    href: user_path(user)) }
      it { should have_link('Sign out',   href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }
      
      describe "When clicking signout linking" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end
    end
  end

  
end

