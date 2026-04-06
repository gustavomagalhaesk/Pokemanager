class Item < ApplicationRecord
  has_many :inventories, dependent: :destroy
  has_many :trainers, through: :inventories
end