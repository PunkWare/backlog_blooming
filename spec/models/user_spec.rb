require 'spec_helper'

describe User do
  before { @user = User.new(name: "Fake", email: "fake@fake.fake", password: "fakefake", password_confirmation: "fakefake") }
  
  subject { @user }
  
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:admin) }
  
  # Session management (with cookie) related
  it { should respond_to(:remember_token) }
  
  # check that user is valid at this point before checking the following tests
  it { should be_valid }
  it { should_not be_admin}
  
  describe "with admin attribute set to 'true'" do
    before { @user.toggle!(:admin) }
    it { should be_admin }
  end
    
  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end
  
  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end
  
  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end
  
  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = " " }
    it { should_not be_valid }
  end
  
  describe "when password is too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
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
    
    it { should_not be_valid }
  end
  
  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end
  
  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end
  
  describe "when the user is trying to authenticate..." do
    before { @user.save } #in order to retrieve it in the database with find_by_email
    let(:found_user) { User.find_by_email(@user.email) }
    
    describe "...with valid password" do
      it { should == found_user.authenticate(@user.password ) }
    end
    
    describe "...with invalid password" do
      let(:user_with_invalid_password) { found_user.authenticate("invalid") } # authenticate returns 'false'
      
      it { should_not == user_with_invalid_password }
      specify { user_with_invalid_password.should be_false } #  ensure that authenticate has returned 'false'
    end
  end
  
  describe "Remember cookie token" do
    before { @user.save }
    its(:remember_token) {should_not be_blank}
  end
end
