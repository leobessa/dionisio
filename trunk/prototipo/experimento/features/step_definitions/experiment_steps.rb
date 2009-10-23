Dado /^que estou logado como adminstrador$/ do 
  Factory.create :admin, :email => "admin@email.com", :password => "adminadmin"
  Dado %q{que estou na página de login de adminstrador}
  E %q{preencho "E-mail" com "admin@email.com"}
  E %q{preencho "Senha" com "adminadmin"}
  E %q{aperto "Entrar"}
end

Dado /^que estou logado$/ do
  Dado %Q{que estou na página de login de usuário}
  E %Q{preencho "E-mail" com "user@email.com"}
  E %Q{preencho "Senha" com "secret"}
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
  User.find_by_email("user@email.com").update_attribute(:stage,Stage.find_by_number(number))
end

Dado /^que a etapa (\d+) está habilitada$/ do |number|
  Stage.find_by_number(number).update_attribute :enabled, true
end

Então /^devo ver os produtos a serem avaliados inicialmente$/ do
   Product.find_all_by_selected(true).each do |p|
    response.should have_selector("#product_#{p.id}")
   end
end

Dado /^que existem 20 produtos pre\-selecionados$/ do
  20.times { Factory :product, :selected => true}
end  

Quando /^eu avaliar todos produtos previamente selecionados$/ do
  Product.find_all_by_selected(true).each do |product|                                  
    rate = 3
    click_link_within "#ajaxful-rating-product-#{product.id}", "#{rate}", :wait_for => :ajax
  end
end