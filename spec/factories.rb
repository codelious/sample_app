# Al utilizar el simbolo ':user' se obtiene Factory Girl 
# para simular el modelo de usuario
Factory.define :user do |user|
  user.name "Mario Espinoza"
  user.email "mario@magrocode.com"
  user.password "foobar"
  user.password_confirmation "foobar"
end

