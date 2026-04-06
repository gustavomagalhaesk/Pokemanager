# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'net/http'
require 'json'

puts "Buscando dados da PokéAPI..."

(1..151).each do |id|
  uri = URI("https://pokeapi.co/api/v2/pokemon/#{id}")
  response = Net::HTTP.get(uri)
  data = JSON.parse(response)

  Pokedex.find_or_create_by!(pokedex_id: id) do |p|
    p.name = data['name'].capitalize
    p.pk_type = data['types'].map { |t| t['type']['name'].capitalize }.join('/')
  end
  puts "Capturado: #{data['name'].capitalize}"
end

puts "\nCriando Trainers..."

# Criar trainers
trainers_data = [
  { name: 'Ash', money: 5000 },
  { name: 'Misty', money: 3000 },
  { name: 'Brock', money: 4000 }
]

trainers_data.each do |data|
  trainer = Trainer.find_or_create_by!(name: data[:name]) do |t|
    t.money = data[:money]
  end
  puts "Treinador criado: #{trainer.name}"
end

puts "\nCriando Items e Inventários..."


item = Item.find_or_create_by!(sku: "pokebola-01", name: "Pokébola")
puts "Item criado: #{item.name}"


Trainer.all.each do |trainer|
  inv = Inventory.find_or_create_by!(trainer: trainer, item: item) do |i|
    i.quantity = 10
  end
  puts "Adicionado #{inv.quantity} Pokébolas para #{trainer.name}"
end

puts "Seeds completado!"