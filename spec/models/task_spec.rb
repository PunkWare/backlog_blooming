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
end
