Dado /^que estou logado como adminstrador$/ do 
  Admin.find_or_create_by_email("admin@email.com").update_attribute(:password,"adminadmin")
  Dado %q{que fui para a página de login de adminstrador}
  E %q{preenchi "email" com "admin@email.com"}
  E %q{preenchi "Senha" com "adminadmin"}
  E %q{apertei o botão "Entrar"}
end

Então /^um e\-mail deve ter sido enviado para "([^\"]*)"$/ do |recipient|
  emails = ActionMailer::Base.deliveries.select { |email| email.to.include?(recipient) }
  emails.should_not be_empty
end