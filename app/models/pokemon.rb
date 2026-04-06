class Pokemon < ApplicationRecord
  belongs_to :trainer
  belongs_to :pokedex, foreign_key: "pokedex_id"

  validates :pokedex_id, uniqueness: { scope: :trainer_id }

  validate :team_limit, on: :create

  def team_limit
      if on_team && trainer.pokemons.where(on_team: true).count >= 6
          errors.add(:on_team, "O time já está cheio (máximo 6 Pokémon).")
      end
  end
end
