require 'spec_helper'

describe User do
  
  before(:each) do
    @attr = {:name => "RobieMan", :email => "usuario@example.com"}  
  end
  
  it "debe entregar una nueva instancia que entregue atributos validos" do
    User.create!(@attr)
  end
  
  it "debe requerir un nombre" do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end
  
  it "debe requerir un email" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end
  
  it "debe rechazar los nombres demasiado largos" do
    long_name = "a" * 51
    long_name_user = User.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
  end
  
  it "debe aceptar una direccion de email valida" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end
  
  it "debe rechazar una direccion de email invalida" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end
  
  it "debe rechazar las direcciones de email duplicadas" do
    # poner un usuario con email valido en la ddbb
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
  it "debe rechazar email identicos por case sensitive" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
    
end
