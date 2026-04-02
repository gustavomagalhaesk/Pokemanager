json.extract! item, :id, :name, :sku, :quantity, :price, :url_image, :created_at, :updated_at
json.url item_url(item, format: :json)
