# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create!(name: 'Petra', email: 'petra@sistemadefrete.com.br', password: 'password', admin: true)
User.create!(name: 'usuario', email: 'qualquer@sistemadefrete.com.br', password: 'password', admin: false)
trans1 = TransportMode.create!(name: 'Frota de Bikes', min_weight: 10, max_weight: 50, min_distance: 10, max_distance: 50, fixed_rate: 7)
trans2 = TransportMode.create!(name: 'Frota de Carros', min_weight: 30, max_weight: 200, min_distance: 30, max_distance: 200, fixed_rate: 10)
TransportMode.create!(name: 'Frota de Caminhões', min_weight: 100, max_weight: 500, min_distance: 100, max_distance: 500, fixed_rate: 15)

(1..5).each do |i|
  Vehicle.create!(nameplate: SecureRandom.alphanumeric(7).upcase, vehicle_brand: 'Caloi', vehicle_model: SecureRandom.alphanumeric(5),
  manifacture_year: 2003, maximum_load: 40 + i, transport_mode: TransportMode.find(1), status: :available)
  Vehicle.create!(nameplate: SecureRandom.alphanumeric(7).upcase, vehicle_brand: 'Nissan', vehicle_model: SecureRandom.alphanumeric(5),
  manifacture_year: 2003, maximum_load: 180 + i, transport_mode: TransportMode.find(2), status: :available)
  Vehicle.create!(nameplate: SecureRandom.alphanumeric(7).upcase, vehicle_brand: 'Caminhãosan', vehicle_model: SecureRandom.alphanumeric(5),
  manifacture_year: 2003, maximum_load: 480 + i, transport_mode: TransportMode.find(3))
end

WeightTable.create!(min: 10, max: 20, value: 0.40, transport_mode: TransportMode.find(1))
WeightTable.create!(min: 21, max: 30, value: 0.50, transport_mode: TransportMode.find(1))
WeightTable.create!(min: 31, max: 49, value: 0.60, transport_mode: TransportMode.find(1))

DistanceTable.create!(min: 10, max: 20, value: 5, transport_mode: TransportMode.find(1))
DistanceTable.create!(min: 21, max: 30, value: 7, transport_mode: TransportMode.find(1))
DistanceTable.create!(min: 31, max: 49, value: 10, transport_mode: TransportMode.find(1))

Deadline.create!(min: 10, max: 20, time: 12, transport_mode: TransportMode.find(1))
Deadline.create!(min: 21, max: 30, time: 24, transport_mode: TransportMode.find(1))
Deadline.create!(min: 31, max: 49, time: 48, transport_mode: TransportMode.find(1))

WeightTable.create!(min: 30, max: 80, value: 0.50, transport_mode: TransportMode.find(2))
WeightTable.create!(min: 81, max: 130, value: 0.75, transport_mode: TransportMode.find(2))
WeightTable.create!(min: 131, max: 200, value: 1.10, transport_mode: TransportMode.find(2))

DistanceTable.create!(min: 30, max: 80, value: 7, transport_mode: TransportMode.find(2))
DistanceTable.create!(min: 81, max: 130, value: 9, transport_mode: TransportMode.find(2))
DistanceTable.create!(min: 131, max: 200, value: 12, transport_mode: TransportMode.find(2))

Deadline.create!(min: 30, max: 80, time: 24, transport_mode: TransportMode.find(2))
Deadline.create!(min: 81, max: 130, time: 48, transport_mode: TransportMode.find(2))
Deadline.create!(min: 131, max: 200, time: 72, transport_mode: TransportMode.find(2))

trans1.active!
trans2.active!

Order.create!(takeout_address:  "Rua da Transportadora 101",weight:  20,heigth:  10,width:  10,depth:  10,delivery_address:  "Rua da Petra 60",
  name:  "Petra",email:  "petra@mail.com",customer_id:  "93940930100138",total_distance: 30,status: :pending)
Order.create!(takeout_address:  "Rua da outra Transportadora 101",weight:  49,heigth:  10,width:  10,depth:  10,delivery_address:  "Rua da Maria 50",
  name:  "Maria",email:  "Maria@mail.com",customer_id:  "93940930100129",total_distance: 49,status: :pending)
Order.create!(takeout_address:  "Rua da outra Transportadora 131",weight:  108,heigth:  10,width:  10,depth:  10,delivery_address:  "Rua da Joaquina 50",
  name:  "Joaquina",email:  "Joaquina@mail.com",customer_id:  "39440930100129",total_distance: 108,status: :pending)
