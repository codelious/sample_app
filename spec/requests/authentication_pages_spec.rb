require 'spec_helper'

describe "Authentication" do
  
  subject { page }
  
  describe "signin page" do
    before { visit signin_path }
    
    it "debe tener h1 Sign in" do
      response.should have_selector('h1', :content => "Sign in")
    end 
    
    it "debe tener title con Sign in" do 
      response.should have_selector('title', :content => "Sign in")
    end
  end
  
  describe "signin" do
    before { visit signin_path }
    
    describe "con informacion invalida" do
      before { click_button "Sign in" }
      
      it "debe tener un titulo 'Sign in'" do
        response.should have_selector('title', :content => 'Sign in')
      end
      it "debe tener un flash de error 'Invalido'" do
        response.should have_selector('div.flash.error', :content => 'Invalido')
      end
      
    end
    
    describe "con informacion valida" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email", :with => user.email
        fill_in "Password", :with => user.password
        click_button "Sign in"
      end
      
      it "debe tener titulo con nombre de usuario" do
        response.should have_selector('title', :content => user.name)
      end
      it "debe tener link al perfil" do
        response.should have_link('Profile', :href => user_path(user) )
      end
      it "debe tener link Sign out" do
        response.should have_link('Sign out', :href => signout_path )
      end
      it "no debe tener un link sign in" do
        response.should_not have_link('Sign in', :href => signin_path )
      end
    end
  end
end
