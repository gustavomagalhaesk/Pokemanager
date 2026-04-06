class Trainer < ApplicationRecord
    has_many :pokemons, dependent: :destroy
    has_many :inventories, dependent: :destroy
    has_many :items, through: :inventories



    def use_item(sku)
        item = Item.find_by(sku: sku)
        inventory = self.inventories.find_by(item: item)

        if inventory && inventory.quantity > 0
            inventory.decrement!(:quantity)
            true
        else
            false
        end
    end
end
