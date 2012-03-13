require 'spec_helper'

describe "user_pages" do
  subject { page }
  
  shared_examples_for "all user pages" do
    it { should have_selector('title', text: full_title(page_title)) }   
    it { should have_selector('h1',    text: heading) }
  end
  
  describe "When testing title and h1 on sign up page, " do
    before { visit signup_path }
    let(:heading) {'Sign up'}
    let(:page_title) {heading}
    
    it_should_behave_like "all user pages"
  end
  
  describe "When providing sign up fields" do
    before { visit signup_path }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button "Create my account" }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "fake"
        fill_in "Email",        with: "fake@fake.fake"
        fill_in "Password",     with: "fakefake"
        fill_in "Confirmation", with: "fakefake"
      end

      it "should create a user" do
        expect do
          click_button "Create my account"
        end.to change(User, :count).by(1)
      end
    end
  end
  
  describe "When testing title and h1 on user page, " do
    # It's possible to use ActiveRecord to create a user in the test database...
    #let(:user) { User.create(name: "Fake", email: "fake@fake.fake", password: "fakefake", password_confirmation: "fakefake") }

    # ...or to use Factory Girl to do the same thing
    let(:user) { FactoryGirl.create(:user) }
    
    before { visit user_path(user) }
    
    let(:heading) {user.name}
    let(:page_title) {heading}
    
    it_should_behave_like "all user pages"
  end
  
  
  
end
