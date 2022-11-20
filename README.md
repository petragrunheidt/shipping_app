# shipping_app
<h2> Configurações </h2>

<ul>
  <li> Versão do Ruby Utilizada: Ruby 3.1.2 </li>
  <li> Versão do framework Rails: 7.0.4 </li>
  <li> Versão do Node: 18.12.0 </li>
  <li> Ferramenta para testes: Rspec </li>
  <li> HTTP Web Server: Puma </li>
  <li> Test driver: Capybara </li>
</ul>

<h2> Setup da aplicação </h2>
<p></p>
  Antes de inicializar a aplicação, rode o comando <code>bin/setup</code> para instalar todas as gems e dependências necessárias para o funcionamento adequado da aplicação.
</p>
<p>
  Em seguida, você pode subir a aplicação utilizando o comando <code>rails s</code> no seu terminal, que permitirá o acesso no endereço <code>https://localhost:3000/</code>
</p>
<p>
  Caso queira rodar todos os testes automatizados, utilize o comando <code>rspec</code>
</p>
<p>
  É recomendado rodar o comando <code>rails db:seed</code> no seu terminal para popular o banco de dados com alguns models pré-cadastrados. Dessa forma, você terá acesso a dois logins de usuários, um comum e um administrador, na qual o administrador possui alguns acessos a mais do que o usuário comum. Ao clicar no botão <code>Fazer Login</code> localizado na barra de navegação da página inicial, você poderá utilizar as seguintes credenciais para se autenticar:
</p>

<p>
  <h3> Usuário comum </h3>
    <ul>
      <li> Email: qualquer@sistemadefrete.com.br </li>
      <li> Senha: password </li>
    </ul>
</p>

<p>
  <h3> Usuário administrador </h3>
    <ul>
      <li> Email: petra@sistemadefrete.com.br </li>
      <li> Senha: password </li>
    </ul>
</p>

<p>
<h2> Specs do sistema </h2>
  <h4> Gems utilizadas: </h4>
  
    * FactoryBot: 
       Gem utilizada para automatizar o processo de população do banco de dados, simplificando as etapas de alguns testes e os deixando mais limpos.

    * Devise:
       Gem utilizada para gerenciar a autenticação dos usuários comuns e admins.

    * Bootstrap:
       Gem utilizada para fazer o front-end e a estilização da aplicação.

    * Rubocop:
       Linter utilizado para garantir que o código se enquadra em padrões de boas práticas.

    * Simplecov:
       Gem utilizada para garantir uma boa cobertura de testes automatizados durante o desenvolvimento
       da aplicação. 
</p>
