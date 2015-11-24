json.array!(@metals) do |metal|
  json.extract! metal, :id, :name, :price, :product_id
  json.url metal_url(metal, format: :json)
end
