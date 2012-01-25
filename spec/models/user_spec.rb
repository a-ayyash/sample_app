# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe User do
  before(:each) do
    @attr = { :name => "Example User", :email => "example@user.com" }
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
end

