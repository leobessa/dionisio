Dado /^que estou logado como adminstrador$/ do 
  Admin.find_or_create_by_email("admin@email.com").update_attribute(:password,"adminadmin")
  Dado %q{que fui para a página de login de adminstrador}
  E %q{preencho "email" com "admin@email.com"}
  E %q{preencho "Senha" com "adminadmin"}
  E %q{aperto "Entrar"}
end

Então /^um e\-mail deve ter sido enviado para "([^\"]*)"$/ do |recipient|
  emails = ActionMailer::Base.deliveries.select { |email| email.to.include?(recipient) }
  emails.should_not be_empty
end                                            

Dado /^que o adminstrador enviou um convite para e\-mail "([^\"]*)"$/ do |recipient|
  Dado %q{que estou logado como adminstrador}
  E %q{estou na página de envio de convites}
  E %Q|preencho "email" com "#{recipient}"|
  E %q{aperto "Enviar convite"}
end  
