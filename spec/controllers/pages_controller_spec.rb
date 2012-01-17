require 'spec_helper'

describe PagesController do
 render_views #tell rspec explicitly to render the views so it can be sure they exist. 





  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'home'
      response.should have_selector("title", :content => " | Home")
    end
    
  end

  describe "GET 'contact'" do
    it "returns http success" do
      get 'contact'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'contact'
      response.should have_selector("title", :content => " | Contact")
    end
    
  end

  describe "GET 'about'" do
    it "returns https success" do
     get 'about'
     response.should be_success
   end
   
   it "should have the right title" do
     get 'about'
     response.should have_selector("title", :content => " | About")
   end
   
  end
end
