# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create!(name: 'Petra', email: 'petra@sistemadefrete.com.br', password: 'password', admin: true)
transport = TransportMode.create!(name: 'Frota de Caminhões', min_weight: 10, max_weight: 100, min_distance: 10, max_distance: 100, fixed_rate: 10)

(10..16).each do |i|
  TransportMode.create!(name: SecureRandom.alphanumeric(6), min_weight: i, max_weight: (10*i), min_distance: i, max_distance: (10*i), fixed_rate: (i/2))
end
(1..10).each do |i|
  Vehicle.create!(nameplate: SecureRandom.alphanumeric(7), vehicle_brand: 'Nissan', vehicle_model: SecureRandom.alphanumeric(5),
  manifacture_year: 2003, maximum_load: 80, transport_mode: transport)
end



