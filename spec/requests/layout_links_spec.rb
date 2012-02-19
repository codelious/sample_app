require 'spec_helper'

describe "LayoutLinks" do
  # describe "GET /layout_links" do
  #  it "works! (now write some real specs)" do
  #    # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
  #    get layout_links_index_path
  #    response.status.should be(200)
  #  end
  # end
  
  it "debe tener una pagina Home en '/'" do
    get '/'
    response.should have_selector('title', :content => "Home")
  end
  
  it "debe tener una pagina Contact en '/contact" do
    get '/contact'
    response.should have_selector('title', :content => "Contact")
  end
  
  it "debe tener una pagina About en '/about'" do
    get '/about'
    response.should have_selector('title', :content => "About")
  end
  
  it "debe tener una pagina Help en '/help'" do
    get '/help'
    response.should have_selector('title', :content => "Help")
  end
  
  it "debe tener una pagina Signup en '/signup'" do
    get '/signup'
    response.should have_selector('title', :content => "Sign up")
  end
  
  it "debe tener los links correctos en el layout" do
    visit root_path
    click_link "About"
    response.should have_selector('title', :content => "About")
    click_link "Help"
    response.should have_selector('title', :content => "Help")
    click_link "Contact"
    response.should have_selector('title', :content => "Contact")
    click_link "Home"
    response.should have_selector('title', :content => "Home")
    click_link "Sign up now!"
    response.should have_selector('title', :content => "Sign up now!")
  end
end
