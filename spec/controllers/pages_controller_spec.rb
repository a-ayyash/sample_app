require 'spec_helper'

describe PagesController do
 render_views #tell rspec explicitly to render the views so it can be sure they exist. 


  before(:each) do
    @base_title = "Ruby On Rails Tutorials Sample App"
  end


  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'home'
      response.should have_selector("title", :content => @base_title + " | Home")
    end
    
  end

  describe "GET 'contact'" do
    it "returns http success" do
      get 'contact'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'contact'
      response.should have_selector("title", :content => @base_title + " | Contact")
    end
    
  end

  describe "GET 'help'" do
    it "should http success" do
      get 'help'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'help'
      response.should have_selector("title", :content => @base_title + " | Help")
    end
    
  end
  describe "GET 'about'" do
    it "returns https success" do
     get 'about'
     response.should be_success
   end
   
   it "should have the right title" do
     get 'about'
     response.should have_selector("title", :content => @base_title + " | About")
   end
   
  end
end
