# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#

require 'spec_helper'

describe User do
  
  describe "password encryption" do
    before(:each) do
      @user = User.create!(@attr)
    end
    
    describe "has_password? method" do
      it "should be true if passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end
      
      it "should be false if passwords dont match" do
        @user.has_password?("invalid").should be_false
      end
    end
    
    describe "authenticate method" do
      it "should return nil on username/password mismatch" do
        wrong_user = User.authenticate(@attr[:email], "wrongpass")
        wrong_user.should be_nil
      end
      
      it "should return user on username/password match" do
        right_user = User.authenticate(@attr[:email], @attr[:password])
        right_user.should == @user
      end
      
      it "should return nil for an email address with no user" do
        nonexistant_user = User.authenticate("foo@bar.com", @attr[:password])
        nonexistant_user.should be_nil
      end
    end

  end


  before(:each) do
    @attr = { 
      :name => "Example User", 
      :email => "example@user.com",
      :password => "foobar", 
      :password_confirmation => "foobar" }
  end
  
  it "should be able to create a User with valid attributes" do
    User.create!(@attr)
  end
  
  it "should have a valid user name" do
   no_name_user = User.new(@attr.merge(:name => ""))
   no_name_user.should_not be_valid 
  end
  
  it "should have a valid email" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end
  
  it "should reject long user names" do
    long_name = "a" * 51
    long_name_user = User.new(@attr.merge(:name=>long_name))
    long_name_user.should_not be_valid
  end
  
  it "should accept valid formatted emails" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      test_user = User.new(@attr.merge(:email=>address))
      test_user.should be_valid
    end
  end
  
  it "should reject invalid formatted emails" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      test_user = User.new(@attr.merge(:email=>address))
      test_user.should_not be_valid
    end
  end
  
  it "should reject duplicate emails" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    duplicate_email_user = User.new(@attr)
    duplicate_email_user.should_not be_valid
  end
  
  it "should require a password and its confirmation" do 
    User.new(@attr.merge(:password => "", :password_confirmation => "")).should_not be_valid
  end
  
  it "should require a password confirmation" do
    User.new(@attr.merge(:password_confirmation => "invalid")).should_not be_valid
  end
  
  it "should reject short passwords" do
    short_password  = "a" * 5
    User.new(@attr.merge(:password => short_password, :password_confirmation => short_password)).should_not be_valid
  end
  
  it "should reject long passwords" do
    long_password = "s" * 41
    User.new(@attr.merge(:password => long_password, :password_confirmation => long_password)).should_not be_valid
  end
  
  it "should respond to encrypted_password attribute" do
    User.create!(@attr).should respond_to(:encrypted_password)
  end
  
end

