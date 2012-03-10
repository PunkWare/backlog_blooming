require 'spec_helper'

describe User do
  before { @user = User.new(name: "Fake", email: "fake@fake.fake") }
  
  subject { @user }
  
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  
  # check that user is valid at this point before checking the following tests
  it { should be_valid }
    
  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end
  
  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end
  
  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end

  # based on regexp : \A[a-z_\-][\w\-]*([(\.|+)][\w\-]+)*@[a-z_\-][\w\-]*(\.[\w\-]+)+\z/i
  # see user.rb for regexp explanations
  
  describe "when email format is invalid" do
    invalid_addresses =  %w[@fake.fake .fake@fake.fake 9fake@fake.fake fake.@fake.fake fakefake.fake fake@fake fake@.fake.fake fake@fake..fake fake@8fake.fake fake@fake.]
    invalid_addresses.each do |invalid_address|
      before { @user.email = invalid_address }
      it { should_not be_valid }
    end
  end
  
  describe "when email format is valid" do
    valid_addresses = %w[fake@fake.fake fake-fake@fake.fake fake.fake@fake.fake fake.fake@fake.fake FAKE@fake.fake FAKE888@fake.fake FAKE.888@fake.fake fake@fake.fake.fake]
    valid_addresses.each do |valid_address|
      before { @user.email = valid_address }
      it { should be_valid }
    end
  end
  
  describe "when email address is already taken" do
    before do
      # duplicate the user and save it in the test database db/test.sqlite3
      user_with_same_email = @user.dup
      user_with_same_email.email = user_with_same_email.email.upcase #to be sure fake@fake.fake and FAKE@FAKE.FAKE are considered the same
      user_with_same_email.save
    end
    
    it { should_not be_valid}
  end
end
