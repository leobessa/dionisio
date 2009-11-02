Dado /^que estou logado como adminstrador$/ do 
  Factory.create :admin, :email => "admin@email.com", :password => "adminadmin"
  Dado %q{que estou na página de login de adminstrador}
  E %q{preencho "E-mail" com "admin@email.com"}
  E %q{preencho "Senha" com "adminadmin"}
  E %q{aperto "Entrar"}
end

Dado /^que estou logado como "([^\"]*)" com a senha "([^\"]*)"$/ do |email, password|
  Dado %Q{que estou na página de login de usuário}
  E %Q{preencho "E-mail" com "#{email}"}
  E %Q{preencho "Senha" com "#{password}"}
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
  Factory.create :user, :email => email, :password => password, :stage_number => 1
end   

Dado /^que estou deslogado$/ do
  visit destroy_user_session_path
end          

Dado /^que "([^\"]*)" está na etapa (\d+)$/ do |email,number|
  User.find_by_email(email).update_attribute(:stage_number,number)
end

Dado /^que a etapa (\d+) está habilitada$/ do |number|
  Stage.find_by_number(number).update_attribute :enabled, true
end

Dado /^que a etapa (\d+) está desabilitada$/ do |number|
  Stage.find_by_number(number).update_attribute :enabled, false
end

Então /^devo ver os produtos a serem avaliados inicialmente$/ do
   Product.selected.each do |p|
    response.should have_selector("#product_#{p.id}")
   end
end

Dado /^que existem 20 produtos pre\-selecionados$/ do
  20.times { Factory.create :product, :selected => true}
end  

Quando /^eu avaliar todos produtos previamente selecionados$/ do
  Product.selected.each do |product|                                  
    rate = 3          
    click_link_within "#star-rating-for-product-#{product.id}", "#{rate}"#, :wait_for => :ajax
  end
end

Given /^que existem os seguintes produtos:$/ do |table|
  table.hashes.each do |product|                                       
    product[:category] = Category.find_or_create_by_name(product[:category])
    Product.create! :name => product[:name], :description => product[:description], :category => product[:category]
  end                                                                 
end  

Dado /^que existem 10 produtos ainda não avaliados por "([^\"]*)"$/ do |email|
  10.times { Factory.create :product }
end

Quando /^avalio mais 10 produtos ainda não avaliados por "([^\"]*)"$/ do |email|
  user = User.find_by_email!(email)
  rated_products = Rating.all(:conditions => {:user_id => user}).map(&:product)
  unrated_products = Product.all - rated_products
  unrated_products[0..9].each do |product|
    Quando %Q{eu vou para a página do produto com id "#{product.id}"}    
    rate = 3
    click_link_within "#star-rating-for-product-#{product.id}", "#{rate}"#, :wait_for => :ajax
  end
end
  