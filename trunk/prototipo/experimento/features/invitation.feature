# language: pt
Funcionalidade: Restrição de cadastro através de convite
 Para restringir o acesso ao experimento
 Como responsável pelo experimento
 Quero enviar convites para os participantes

 Cenário: Envio de convite para participante
   Dado que estou logado como adminstrador
   E estou na página de envio de convites
   Quando preencho "email" com "convidado@email.com"
   E aperto "Enviar convite"
   Então devo ver "Convite enviado para convidado@email.com"
   E um e-mail deve ter sido enviado para "convidado@email.com"
   
 Cenário: Casdastro de participante convidado 
   Dado que o adminstrador enviou um convite para e-mail "example@example.com"
   Então devo receber um email
   Quando abrir o email
   Então devo ver "aqui" no corpo do email 
   Quando clicar no link "aqui" do email
   Então devo estar na página de cadastro de participante

   Quando preencho o formulário com:
   | Nome                 | João da Silva     |
   | Senha                | change-me         |
   | Confirmação da senha | change-me         |
   E escolho a opção "Masculino"
   E escolho a opção "18 a 25" 
   E aperto "Criar minha conta"
   Então devo ver "Seu cadastro foi realizado com sucesso."