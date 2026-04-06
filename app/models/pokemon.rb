class Pokemon < ApplicationRecord
  belongs_to :trainer
  belongs_to :pokedex, foreign_key: "pokedex_id"

  validates :pokedex_id, uniqueness: { scope: :trainer_id }
end
