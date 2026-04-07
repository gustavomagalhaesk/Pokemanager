class Pokedex < ApplicationRecord
    has_many :pokemons, dependent: :destroy
end
