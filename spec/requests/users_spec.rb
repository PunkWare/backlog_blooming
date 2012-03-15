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
    let(:create_account_button) {'Create my account'}
    
    before { visit signup_path }

    describe "with invalid information," do
      it "should not create a user" do
        expect { click_button create_account_button }.not_to change(User, :count)
      end
      
      describe "should display error messages" do
        before { click_button create_account_button }
        
        it { should have_content('Password can\'t be blank') }
        it { should have_content('Name can\'t be blank') }
        it { should have_content('Email can\'t be blank') }
        it { should have_content('Email is invalid') }
        it { should have_content('Password is too short') }
        it { should have_content('Password confirmation can\'t be blank') }   
      end
      
      describe "should display password matching error message" do
        before do
          fill_in "Password",     with: "fakefake"
          fill_in "Confirmation", with: "fakefak"
          click_button create_account_button
        end
        
        it { should have_content('Password doesn\'t match confirmation') }   
      end
    end

    describe " with valid information, " do
      before do
        fill_in "Name",         with: "fake"
        fill_in "Email",        with: "fake@fake.fake"
        fill_in "Password",     with: "fakefake"
        fill_in "Confirmation", with: "fakefake"
      end

      it "should create a user" do
        expect do
          click_button create_account_button
        end.to change(User, :count).by(1)
      end
      
      describe "after saving the user" do
        before { click_button create_account_button }
        let(:user) { User.find_by_email('fake@fake.fake') }

        it { should have_selector('title', text: user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
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
