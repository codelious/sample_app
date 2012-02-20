require 'spec_helper'

describe "Paginas de usuario" do
  
  subject { page }
  
  
  describe "signup" do
    
    before { visit signup_path }
    
      describe "con informacion invalida" do
        it "no debe crear un usuario" do
          expect {click_button "Sign up" }.not_to change(User, :count)
        end
      end
    
      describe "mensajes de error" do
        before { click_button "Sign up" }

        let(:error) { 'errores prohiben que este usuario se guarde' }

        it "debe tener title con Sign up" do
          response.should have_selector('title', :content => 'Sign up')
        end
        #it "debe tener contenido de error" do
        #  response.should have_content(error)
        #end
        
      end
            
      describe "con informacion valida" do
        before do
          fill_in "Name", with: "Usuario Ejemplo"
          fill_in "Email", with: "user@example.com"
          fill_in "Password", with: "foobar"
          fill_in "Confirmation", with: "foobar"
        end
        
        it "debe crear un usuario" do
          expect { click_button "Sign up" }.to change(User, :count).by(1)
        end
        
        describe "despues de guardar el usuario" do
          before { click_button "Sign up" }
          let(:user) { User.find_by_email('user@example.com') }
          
          it "debe tener titulo con nombre usuario" do
            response.should have_selector('title', :content => user.name)
          end
          it "debe tener flash success con 'Bienvenido'" do
            response.should have_selector('div.flash.success', :content => 'Bienvenido')
          end 
        
        end
      end
  end
end