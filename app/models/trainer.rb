class Trainer < ApplicationRecord
    has_many :pokemons, dependent: :destroy
    has_many :inventories
    has_many :items, through: :inventories

    def use_item(sku)
        item = Item.find_by(sku: sku)
        inventory = self.inventories.find_by(item: item)
        
        if inventory && inventory.quantity > 0
            inventory.decrement!(:quantity)
            return true
        else
            return false
        end
    end
            
end
