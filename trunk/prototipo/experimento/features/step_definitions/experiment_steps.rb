Dado /^que estou logado como adminstrador$/ do
  Dado %q{que fui para a página de login de adminstrador}
  E %q{preenchi "email" com "admin@email.com"}
  E %q{preenchi "senha" com "adminadmin"}
  E %q{apertei o botão "Entrar"}
end

Dado /^estou na pagina de envio de convites$/ do
  pending
end

Dado /^preencho "([^\"]*)" com "([^\"]*)"$/ do |arg1, arg2|
  pending
end

Dado /^aperto "([^\"]*)"$/ do |arg1|
  pending
end

Então /^devo ver "([^\"]*)"$/ do |arg1|
  pending
end

Então /^um e\-mail deve ter sido enviado para "([^\"]*)"$/ do |arg1|
  pending
end