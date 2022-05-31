# :truck: Frete nos Trilhos

- Projeto em andamento.
- Sistema de frete simplificado para gestão de produtos em galpões.

## :clipboard: Product Backlog para acompanhar o desenvolvimento do projeto

- https://trello.com/b/GSzb6Wzl/frete-nos-trilhos

## :desktop_computer: Stack

- Ruby 3.1.1
- Rails 7.0.2.3
- SQLite 3

### Gems utilizadas
- RSpec
- Capyabra
- Byebug
- Devise

## :arrows_counterclockwise: Rodando o projeto

- Clone o projeto: `git@github.com:thiagogondim/fretenostrilhos.git`
- `bundle install`
- `rails db:prepare db:seed`
- Levante a aplicação com `rails server`

## :wrench: Experimentando o projeto
- Após os passos acima, o projeto contará com os seguintes usuários para testar o sistema:
  - Admin User: manoel@sistemadefrete.com.br
    - Senha: 123456 
  - Carrier User: jef@alphatransportes.com.br
    - Senha: 123456
- *Admins são responsáveis por realizar o cadastro dos intervalos de preços e intervalos de prazo.
- *Usuários das Transportadoras são responsáveis por cadastrar preços e prazos de acordo com os intervalos previamente estabelecidos pelos Admins. 

## :memo: Observações

Projeto de aprendizado do framework Ruby on Rails e de boas práticas de programação. O TDD foi de uso intensivo durante o curso sendo o CRUD feito de forma manual (nada de scaffold) no intuito de fortalecer o fluxo de Desenvolvimento Guiado por Testes em cada item do CRUD de cada Model.

## :floppy_disk: Modelo de Dados
![db_model_frete_nos_trilhos](https://user-images.githubusercontent.com/14118336/171166659-d8767ed0-4cde-4319-aec2-fffffbc11e56.png)
*Modelo de dados contruído utilizando o Navicat Data Modeler.

## :paperclip: Aprendizagens
- É necessário equilibrar prazos, expectativas e habilidade técnica.
- Não pule o fluxo de TDD achando que vai ser mais rápido desenvolvendo alguma feature. Você se arrependerá amargamente durante o debug.
- Cuidado com o preciosismo (_golum, golum_). Ele pode te fazer perder muito tempo com coisas desnecessárias.
- Make it Work, Right and Fast. Gerar valor em um padrão mínimo de qualidade e em uma estrutua que permita a evolução, depois melhorar a estrutura (obs: não é go horse).   
