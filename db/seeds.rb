# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create!(name: 'Petra', email: 'petra@sistemadefrete.com.br', password: 'password', admin: true)
TransportMode.create!(name: 'Frota de Bikes', min_weight: 10, max_weight: 50, min_distance: 10, max_distance: 50, fixed_rate: 7)
TransportMode.create!(name: 'Frota de Carros', min_weight: 50, max_weight: 200, min_distance: 50, max_distance: 200, fixed_rate: 10)
TransportMode.create!(name: 'Frota de Caminhões', min_weight: 100, max_weight: 500, min_distance: 100, max_distance: 500, fixed_rate: 15)

(1..5).each do |i|
  Vehicle.create!(nameplate: SecureRandom.alphanumeric(7).upcase, vehicle_brand: 'Caloi', vehicle_model: SecureRandom.alphanumeric(5),
  manifacture_year: 2003, maximum_load: 40 + i, transport_mode: TransportMode.find(1))
  Vehicle.create!(nameplate: SecureRandom.alphanumeric(7).upcase, vehicle_brand: 'Nissan', vehicle_model: SecureRandom.alphanumeric(5),
  manifacture_year: 2003, maximum_load: 180 + i, transport_mode: TransportMode.find(2))
  Vehicle.create!(nameplate: SecureRandom.alphanumeric(7).upcase, vehicle_brand: 'Caminhãosan', vehicle_model: SecureRandom.alphanumeric(5),
  manifacture_year: 2003, maximum_load: 480 + i, transport_mode: TransportMode.find(3))
end



