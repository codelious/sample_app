require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'new'" do
    it "debe ser satisfactorio" do
      get 'new'
      response.should be_success
    end
    
    it "debe tener el titulo correcto" do
      get 'new'
      response.should have_selector("title", :content => "Sign up")
    end
  end
  
  describe "GET 'show'" do
    
    before(:each) do
      @user = Factory(:user)
    end
    
    it "debe ser satisfactorio" do
      get :show, :id => @user
      response.should be_success
    end
    
    it "debe encontrar el usuario correcto" do
      get :show, :id => @user
      assigns(:user).should == @user
    end
    
    it "debe tener titulo correcto" do
      get :show, :id => @user
      response.should have_selector("title", :content => @user.name)
    end
    
    it "debe incluir el nombre de usuario" do
      get :show, :id => @user
      response.should have_selector("h1", :content => @user.name)
    end
    
    it "debe tener una imagen de perfil" do
      get :show, :id => @user
      response.should have_selector("h1>img", :class => "gravatar")
    end
    
  end

end
