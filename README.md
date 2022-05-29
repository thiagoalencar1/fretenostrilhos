# :truck: Frete nos Trilhos

- Projeto em andamento.
- Sistema de frete simplificado para gestão de produtos em galpões.

## :clipboard: Product Backlog para acompanhar o desenvolvimento do projeto

- https://trello.com/b/GSzb6Wzl/frete-nos-trilhos

## :desktop_computer: Stack

- Ruby 3.1.1
- Rails 7.0.2.3
- SQLite 3

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

## :floppy_disk: Modelo de Dados\*

\*O modelo de dados está em amadurecimento e será modificado de acordo com o avanço da implementação do sistema.
![db_model](https://user-images.githubusercontent.com/14118336/170393011-3b6ed362-cabb-4eab-a63b-d70aefada719.png)

## :paperclip: Aprendizagens
Dediquei um tempo razoável tentando encontrar a melhor modelagem para o banco de dados. Não só desenhando o banco como também no momento de implementar uma lógica condizente com o modelo desejado. Cito, por exemplo, o ponto de preços e prazos e também na questão da ordem de serviço e endereços. Por conta da pouca experiência na implementação de um tipo de modelagem mais refinada utilizando o Rails, isto tomou muito tempo e ficou apertado para implementar algumas outras features solicitadas da melhor forma possíve. Desta forma, fica o registro da experiência: é necessário adequar expectativas, prazos e habilidade técnica adequada.
