require 'spec_helper'

describe "user_pages" do
  subject { page }
  
  shared_examples_for "all user pages" do
    it { should have_selector('title', text: full_title(page_title)) }   
    it { should have_selector('h1',    text: heading) }
  end
  
  describe "Sign up page" do
    before { visit signup_path }
    let(:heading) {'Sign up'}
    let(:page_title) {heading}
    
    it_should_behave_like "all user pages"
  end
  
end
