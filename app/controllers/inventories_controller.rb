class InventoriesController < ApplicationController
  def new
    @inventory = Inventory.new
    @item = Item.find(params[:item_id])
  end

  def create
    @inventory = Inventory.new(inventory_params)

    @item = Item.find(@inventory.item_id)
    @trainer = Trainer.find(@inventory.trainer_id)

    total_price_usd = @item.price * @inventory.quantity
    total_price_brl = CurrencyService.convert("USD", "BRL", total_price_usd)

    if @trainer.money >= total_price_brl
      ActiveRecord::Base.transaction do
        @trainer.update!(money: @trainer.money - total_price_brl)
        existing = Inventory.find_by(
          trainer_id: @trainer.id,
          item_id: @item.id)

        if existing
          existing.update!(quantity: existing.quantity + @inventory.quantity)
        else
          @inventory.save!
        end
      end

      redirect_to pokeshop_path, notice: "Compra realizada com sucesso!"
    else
      redirect_to pokeshop_path, alert: "Dinheiro insuficiente!"
    end
  end

  private

  def inventory_params
    params.require(:inventory).permit(:item_id, :trainer_id, :quantity)
  end
end
