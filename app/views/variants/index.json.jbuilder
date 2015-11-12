json.array!(@variants) do |variant|
  json.extract! variant, :id
  json.url variant_url(variant, format: :json)
end
