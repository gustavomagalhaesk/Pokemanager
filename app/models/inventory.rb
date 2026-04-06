class Inventory < ApplicationRecord
  belongs_to :trainer
  belongs_to :item
end
