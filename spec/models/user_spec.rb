  require 'spec_helper'

describe User do
  
  before(:each) do
    @attr = {
      :name => "RobieMan", 
      :email => "usuario@example.com",
      :password => "foobar",
      :password_confirmation => "foobar"
      }  
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
  
  describe "validaciones de password" do
    
    it "debe requerir un password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).should_not be_valid
    end
    
    it "debe requerir password_confirmation coincidente" do
      User.new(@attr.merge(:password_confirmation => "invalid")).should_not be_valid
    end
    
    it "debe rechazar password cortos" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end
    
    it "debe rechazar password largos" do
      long = "a" * 41
      hash = @attr.merge(:password => long, :password_confirmation => long )
      User.new(hash).should_not be_valid
    end
  end
  
  describe "el cifrado de contrasenyas" do
    
    before(:each) do
      @user = User.create!(@attr)
    end
    
    it "debe tener un atributo de password encriptado" do
      @user.should respond_to(:encrypted_password)
    end
    
    it "debe establecer el password encriptado" do
      @user.encrypted_password.should_not be_blank
    end
    
    describe "metodo has_password?" do
      
      it "debe ser true si los password coinciden" do
        @user.has_password?(@attr[:password]).should be_true
      end
      
      it "debe ser falso si los password no coinciden" do
        @user.has_password?("invalid").should be_false
      end
    end
    
    describe "metodo authenticate" do
      
      it "debe retornar nil sobre falta de coincidencia email/password" do
        wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
        wrong_password_user.should be_nil
      end
      
      it "debe retornar nil para una direccion email con ningun usuario" do
        nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
        nonexistent_user.should be_nil
      end
      
      it "should return the user on email/password match" do
        matching_user = User.authenticate(@attr[:email], @attr[:password])
        matching_user.should == @user
      end
    end
  end
    
end
