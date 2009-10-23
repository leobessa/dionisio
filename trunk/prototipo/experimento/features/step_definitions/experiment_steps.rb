Dado /^que estou logado como adminstrador$/ do 
  Factory.create :admin, :email => "admin@email.com", :password => "adminadmin"
  Dado %q{que estou na página de login de adminstrador}
  E %q{preencho "E-mail" com "admin@email.com"}
  E %q{preencho "Senha" com "adminadmin"}
  E %q{aperto "Entrar"}
end

Dado /^que estou logado$/ do 
  Dado %Q{que estou na página de login de usuário}
  E %Q{preencho "E-mail" com "#{@user.email}"}
  E %Q{preencho "Senha" com "#{@password}"}
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

Dado /^que estou na etapa (\d+)$/ do |number|
  @user.update_attribute(:stage,Stage.find_by_number(number))
end

Dado /^que sou o usuário "([^\"]*)" com senha "([^\"]*)"$/ do |email, password|
  @user = Factory.create :user, :email => email, :password => password
  @password = password
end

Dado /^que a etapa (\d+) está habilitada$/ do |number|
  Stage.find_by_number(number).update_attribute :enabled, true
end

Então /^devo ver 20 produtos a serem avaliados$/ do
  response.should have_selector("dd",:class => 'product', :count => 20)
end

Dado /^que existem 20 produtos pre\-selecionados$/ do
  20.times { Factory :product, :selected => true}
end  

Quando /^eu avaliar todos os 20 produtos$/ do
  Product.find_by_selected(true) do                                   
    rate = (1..5).to_a.rand
    click_link_within "#ajaxful-rating-product-#{product.id}", "#{rate}"
  end
end