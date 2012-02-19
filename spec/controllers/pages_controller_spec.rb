require 'spec_helper'

describe PagesController do
  render_views
  
  before(:each) do
    @base_title = "Ruby on Rails Tutorial Sample App"
  end
  
  describe "GET 'home'" do
    it "retorna http exitoso" do
      get 'home'
      response.should be_success
    end
    it "debe tener el titulo correcto" do
      get 'home'
      response.should have_selector("title", 
                          :content => @base_title + " | Home")
    end
  end

  describe "GET 'contact'" do
    it "retorna http exitoso" do
      get 'contact'
      response.should be_success
    end
    it "debe tener el titulo correcto" do
      get 'contact'
      response.should have_selector("title", 
                          :content => @base_title + " | Contact")
    end
  end

  describe "GET 'about'" do
    it "retorna http exitoso" do
      get 'about'
      response.should be_success
    end
    it "debe tener el titulo correcto" do
      get 'about'
      response.should have_selector("title", 
                          :content => @base_title + " | About")
    end
  end
  
  describe "GET 'help'" do
    it "retorna http exitoso" do
      get 'help'
      response.should be_success
    end
    it "debe tener el titulo correcto" do
      get 'help'
      response.should have_selector("title",
                          :content => @base_title + " | Help")
    end
  end
end
