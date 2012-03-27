require 'spec_helper'

describe "Regarding all user pages :" do
  subject { page }
  
  shared_examples_for "all user pages" do
    it { should have_title(full_title(page_title)) }   
    it { should have_heading(heading) }
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
        
        it { should have_flash_message('Password can\'t be blank','error') }
        it { should have_flash_message('Name can\'t be blank','error') }
        it { should have_flash_message('Email can\'t be blank','error') }
        it { should have_flash_message('Email is invalid','error') }
        it { should have_flash_message('Password is too short','error') }
        it { should have_flash_message('Password confirmation can\'t be blank','error') }   
      end
      
      describe "should display password matching error message" do
        before do
          fill_in "Password",     with: "fakefake"
          fill_in "Confirmation", with: "fakefak"
          click_button create_account_button
        end
        
        it { should have_flash_message('Password doesn\'t match confirmation','error') }   
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
        let(:user) { User.find_by_email('fake@fake.fake') }
        before { click_button create_account_button }      

        it { should have_title(user.name) }
        it { should have_flash_message('Welcome','success') }
      end
    end
  end
  
  describe "When testing title and h1 on view profile page, " do
    # It's possible to use ActiveRecord to create a user in the test database...
    #let(:user) { User.create(name: "Fake", email: "fake@fake.fake", password: "fakefake", password_confirmation: "fakefake") }

    # ...or to use Factory Girl to do the same thing
    let(:user) { FactoryGirl.create(:user) }
    
    # must sign in user to comply with authorization restrictions
    before do
      sign_in user
      visit user_path(user)
    end
    
    let(:heading) {user.name}
    let(:page_title) {heading}
    
    it_should_behave_like "all user pages"
  end
  
  describe "When testing title and h1 on edit profile page, " do
    let(:user) { FactoryGirl.create(:user) }
    
    # must sign in user to comply with authorization restrictions
    before do
      sign_in user
      visit edit_user_path(user)
    end
        
    let(:heading) {'Update your profile'}
    let(:page_title) {'Edit user'}
    
    it_should_behave_like "all user pages"
    it { should have_link('change', href: 'http://gravatar.com/emails') }
  end
  
  describe "When providing edit fields" do
    let(:save_profile_button) {'Save changes'}
    let(:user) { FactoryGirl.create(:user) }
    
    # must sign in user to comply with authorization restrictions
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "with invalid information," do
      
      describe "should display error messages" do
        
        # by default the two fields are already filled with user's information
        # they are emptied so that errors messages can be checked
        before do
          fill_in "Name",  with: ""
          fill_in "Email", with: ""
          click_button save_profile_button
        end
        
        it { should have_flash_message('Name can\'t be blank','error') }
        it { should have_flash_message('Email can\'t be blank','error') }
        it { should have_flash_message('Email is invalid','error') }
        it { should have_flash_message('Password is too short','error') }
        it { should have_flash_message('Password confirmation can\'t be blank','error') }   
      end
      
      describe "should display password matching error message" do
        before do
          fill_in "Password",     with: "fakefake"
          fill_in "Confirmation", with: "fakefak"
          click_button save_profile_button
        end
        
        it { should have_flash_message('Password doesn\'t match confirmation','error') }   
      end
    end

    describe " with valid information, " do
      let(:updated_name)  { "update" }
      let(:updated_email) { "update@update.update" }
            
      before do
        fill_in "Name",         with: updated_name
        fill_in "Email",        with: updated_email
        fill_in "Password",     with: user.password
        fill_in "Confirmation", with: user.password
        click_button save_profile_button
      end

      it { should have_title(updated_name) }
      it { should have_flash_message('Profile updated','success') }
      it { should have_link('Sign out', href: signout_path) }
      
      # Check that the name and email have been indeed modified
      specify { user.reload.name.should  == updated_name }
      specify { user.reload.email.should == updated_email }
      
    end
  end
  
  describe "When displaying index users" do
    
    # as a non admin-user
    let(:user) { FactoryGirl.create(:user) }

    before do
      sign_in user
      visit users_path
    end

    it { should_not have_selector('title', text: 'All users') }
      
    # as a admin-user  
    describe "as an admin user" do  
      let(:admin)   { FactoryGirl.create(:admin) }
      let!(:another_admin)   { FactoryGirl.create(:admin) }
        
      before do
        sign_in admin
        visit users_path
      end
     
      describe "pagination" do
        before(:all) { 30.times { FactoryGirl.create(:user) } }
        after(:all)  { User.delete_all }

        let(:first_page)  { User.paginate(page: 1) }
        let(:second_page) { User.paginate(page: 2) }

        it { should have_link('Next') }
        it { should have_link('2') }

        it "should list each user" do
          User.all[0..2].each do |user|
            page.should have_selector('li', text: user.name)
          end
        end

        it "should list the first page of users" do
          first_page.each do |user|
            page.should have_selector('li', text: user.name)
          end
        end

        it "should not list the second page of users" do
          second_page.each do |user|
            page.should_not have_selector('li', text: user.name)
          end
        end

        describe "showing the second page" do
          before { visit users_path(page: 2) }

          it "should list the second page of users" do
            second_page.each do |user|
              page.should have_selector('li', text: user.name)
            end
          end
        end    
      end
      
      it { should have_link('delete', href: user_path(User.first)) }

      it "should be able to delete another user" do
        expect { click_link('delete') }.to change(User, :count).by(-1)
      end
      
      # No delete link for other admin users (to prevent admin users from destroying themselves)
      it { should_not have_link('delete', href: user_path(admin)) }
      
      # No delete link for the current admin user (to avoid admin deleting itself)
      it { should_not have_link('delete', href: user_path(another_admin)) }
    end
  end
end
