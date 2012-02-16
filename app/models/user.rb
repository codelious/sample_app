class User < ActiveRecord::Base
  
  # atributo virtual
  attr_accessor :password
  # atributos de la tabla
  attr_accessible :name, :email, :password, :password_confirmation
  
  # expresion regular de validacion para email
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :name, :presence => true,
                   :length => { :maximum => 50 }
                   
  validates :email, :presence => true,
                    :format => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }
                    
  validates :password, :presence => true,
                       :confirmation => true,
                       :length => { :within => 6..40 }
  
  before_save :encrypt_password
  
  # devuelve verdadero si la contraseña del usuario coincide con la contraseña enviada
  def has_password?(submitted_password)
    # compare encrypted_password with the encrypted version of
    # submitted password
    encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end
  
  private
  
    def encrypt_password
      self.salt = make_salt unless has_password?(password)
      self.encrypted_password = encrypt(password)
    end
    
    def encrypt(string)
      # solamente una implementacion temporal
      secure_hash("#{salt}--#{string}")
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
  
end
