Dado /^que estou logado como adminstrador$/ do 
  Factory.create :admin, :email => "admin@email.com", :password => "adminadmin"
  Dado %q{que estou na página de login de adminstrador}
  E %q{preencho "E-mail" com "admin@email.com"}
  E %q{preencho "Senha" com "adminadmin"}
  E %q{aperto "Entrar"}
end

Dado /^que estou logado como usuário "([^\"]*)"$/ do |email|
  Factory.create :user, :email => email, :password => "secret"
  Dado %q{que estou na página de login de usuário}
  E %Q{preencho "E-mail" com "#{email}"}
  E %q{preencho "Senha" com "secret"}
  E %q{aperto "Entrar"}
end

Então /^um e\-mail deve ter sido enviado para "([^\"]*)"$/ do |recipient|
  Then %Q|"#{recipient}" should receive an emails|
end                                            

Dado /^que o adminstrador enviou um convite para e\-mail "([^\"]*)"$/ do |recipient|
  Dado %q{que estou logado como adminstrador}
  E %q{estou na página de envio de convites}
  E %Q|preencho "email" com "#{recipient}"|
  E %q{aperto "Enviar convite"}
end    

Dado /^que existe um participante com e\-mail "([^\"]*)" e senha "([^\"]*)"$/ do |email, password|
  Factory.create :user, :email => email, :password => password
end   

Dado /^que estou deslogado$/ do
  visit destroy_user_session_path
end
