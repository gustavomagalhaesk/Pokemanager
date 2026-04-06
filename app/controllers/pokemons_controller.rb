class PokemonsController < ApplicationController
  before_action :set_pokemon, only: %i[ show edit update destroy ]

  # GET /pokemons or /pokemons.json
  def index
    @pokemons = Pokemon.joins(:pokedex, :trainer).all

    if params[:query].present?
      @pokemons = @pokemons.where(
        "pokedex.name LIKE ? OR trainers.name LIKE ?", 
        "%#{params[:query]}%", 
        "%#{params[:query]}%"
      )
    end
  end

  # GET /pokemons/1 or /pokemons/1.json
  def show
  end

  # GET /pokemons/new
  def new
    @pokemon = Pokemon.new(trainer_id: params[:trainer])
  end

  # GET /pokemons/1/edit
  def edit
  end

  # POST /pokemons or /pokemons.json
  def create
    t_id = pokemon_params[:trainer_id]
    p_id = pokemon_params[:pokedex_id]

    @trainer = Trainer.find(t_id)
    @existing_pokemon = Pokemon.find_by(trainer_id: t_id, pokedex_id: p_id)

    if @existing_pokemon
      @existing_pokemon.increment!(:level)
      redirect_to pokemons_path, notice: "Nível aumentado!" and return
    end

    @pokemon = Pokemon.new(pokemon_params)
    @pokemon.level ||= 1 

    if @pokemon.valid?
      if @trainer.use_item("pokebola-01")
        if @pokemon.save
          redirect_to pokemons_path, notice: "Capturado!"
        else
          puts "ERRO DE BANCO: #{@pokemon.errors.full_messages}"
          render :new, status: :unprocessable_entity
        end
      else
        redirect_to new_pokemon_path(trainer: t_id), alert: "Sem Pokébolas!"
      end
    else
      puts "ERRO DE VALIDAÇÃO: #{@pokemon.errors.full_messages}"
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /pokemons/1 or /pokemons/1.json
  def update
    respond_to do |format|
      if @pokemon.update(pokemon_params)
        format.html { redirect_to @pokemon, notice: "Pokemon was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @pokemon }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @pokemon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pokemons/1 or /pokemons/1.json
  def destroy
    @pokemon.destroy!

    respond_to do |format|
      format.html { redirect_to pokemons_path, notice: "Pokemon was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pokemon
      @pokemon = Pokemon.find(params[:id])
    end

    def pokemon_params
      params.require(:pokemon).permit(:trainer_id, :pokedex_id, :level, :on_team)
    end
end
