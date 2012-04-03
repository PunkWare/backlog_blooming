require 'spec_helper'

describe "Regarding all task pages :" do
  subject { page }
  
  shared_examples_for "all task pages" do
    it { should have_title(full_title(page_title)) }   
    it { should have_heading(heading) }
  end
  
  describe "When testing title and h1 on edit page, " do
    let(:user) { FactoryGirl.create(:user) }
    let(:task) { FactoryGirl.create(:task, user: user, code: "T1", title: "Task 1", remaining_effort: 16) }
    
    # must sign in user to comply with authorization restrictions
    before do
      sign_in user
      visit edit_task_path(task)
    end
        
    let(:heading) {'Update your task'}
    let(:page_title) {'Edit task'}
    
    it_should_behave_like "all task pages"
  end
  
  describe "When providing edit fields" do
    let(:save_profile_button) {'Save changes'}
    let(:user) { FactoryGirl.create(:user) }
    let(:task) { FactoryGirl.create(:task, user: user, code: "T1", title: "Task 1", remaining_effort: 16) }
    
    # must sign in user to comply with authorization restrictions
    before do
      sign_in user
      visit edit_task_path(task)
    end

    describe "with invalid information," do
      
      describe "should display error messages" do
        
        # by default the two fields are already filled with user's information
        # they are emptied so that errors messages can be checked
        before do
          fill_in "Code",  with: ""
          fill_in "Title", with: ""
          fill_in "Remaining effort", with: ""
          click_button save_profile_button
        end
        
        it { should have_flash_message('Code can\'t be blank','error') }
        it { should have_flash_message('Title can\'t be blank','error') }
        it { should have_flash_message('Remaining effort can\'t be blank','error') } 
        it { should have_flash_message('Remaining effort is invalid','error') }  
      end
      
    end

    describe " with valid information, " do
      let(:updated_code)  { "code updated" }
      let(:updated_title) { "title updated" }
      let(:updated_remaining_effort) { 10 }
            
      before do
        fill_in "Code",         with: updated_code
        fill_in "Title",        with: updated_title
        fill_in "Remaining effort",     with: updated_remaining_effort
        click_button save_profile_button
      end

      it { should have_flash_message('Task updated','success') }
      it { should have_title(full_title('My tasks')) }
      
      # Check that the data have been indeed modified
      specify { task.reload.code.should  == updated_code }
      specify { task.reload.title.should == updated_title }
      specify { task.reload.remaining_effort.should == updated_remaining_effort }
    end
  end
end