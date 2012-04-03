require 'spec_helper'

describe Task do
  
  let(:user) { FactoryGirl.create(:user) }
  before do
    @task = user.tasks.build(code: "T1", title: "Task 1", remaining_effort: 16)
  end
  
  subject { @task }
  
  it { should respond_to(:code) }
  it { should respond_to(:title) }
  it { should respond_to(:remaining_effort) }
  it { should respond_to(:user_id) }
  
  # check that task.user is valid
  it { should respond_to(:user) }
  its(:user) { should == user }
  
  it { should respond_to(:story_id) }

  it {should be_valid }
  
  describe "When user_id is not present" do
    before { @task.user_id = nil }
    it { should_not be_valid }
  end
  
  describe "When code is not present" do
    before { @task.code = nil }
    it { should_not be_valid }
  end
  
  describe "When code is blank" do
    before { @task.code =  " " }
    it { should_not be_valid }
  end
  
  describe "When title is not present" do
    before { @task.title = nil }
    it { should_not be_valid }
  end
  
  describe "When title is blank" do
    before { @task.title = " " }
    it { should_not be_valid }
  end
  
  describe "When remaining effort is not present" do
    before { @task.remaining_effort = nil }
    it { should_not be_valid }
  end
  
  describe "When remaining effort is blank" do
    before { @task.remaining_effort = " " }
    it { should_not be_valid }
  end
  
  # based on regexp : ^[\d ]+$/i
  # see task.rb for regexp explanations
  describe "when remaining  effort format is invalid" do
    invalid_formats =  %w[-1 +1 1.0 1,0 a 1e5 ]
    invalid_formats.each do |invalid_format|
      before { @task.remaining_effort = invalid_format}
      it { should_not be_valid }
    end
  end
  describe "when remaining effort format is valid" do
    valid_formats = %w[ 1 1456 ]
    valid_formats.each do |valid_format|
      before { @task.remaining_effort = valid_format }
      it { should be_valid }
    end
  end
end
