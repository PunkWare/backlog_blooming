require 'spec_helper'

describe Task do
  
  let(:user) { FactoryGirl.create(:user) }
  before do
    @task = Task.new(code: "T1", title: "Task 1", remaining_effort: 16, user_id: user.id)
  end
  
  subject { @task }
  
  it { should respond_to(:code) }
  it { should respond_to(:title) }
  it { should respond_to(:remaining_effort) }
  it { should respond_to(:user_id) }
  it { should respond_to(:story_id) }

end
