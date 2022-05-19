# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create!(name: 'Manoel de Barros', email: 'manoel@sistemadefrete.com.br', password: 'carambolas')
User.create!(name: 'Jefferson Luis', email: 'jef@alfatransportes.com.br', password: 'jabuticaba')

Carrier.create!(
  brand_name: 'system', corporate_name: 'system',
  email_domain: '@sistemadefrete.com.br', taxpayer_number: '00000000000000',
  status: 'active'
)

Carrier.create!(
  brand_name: 'Alfa Transportes', corporate_name: 'Alta Transportes LTDA',
  email_domain: '@alfatransportes.com.br', taxpayer_number: '38554111000112',
  status: 'active'
)

Carrier.create!(
  brand_name: 'Beta Transportes', corporate_name: 'Beta Transportes LTDA',
  email_domain: '@betatransportes.com.br', taxpayer_number: '37846022000187',
  status: 'active'
)

Carrier.create!(
  brand_name: 'Gama Transportes', corporate_name: 'Gama Transportes LTDA',
  email_domain: '@gamatransportes.com.br', taxpayer_number: '93195868000175',
  status: 'active'
)

