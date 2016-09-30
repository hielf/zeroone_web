json.products do
  json.array! @products do |product|
    json.id               product.id
    json.name             product.name
    json.prize            product.prize
    json.image            product.image
    json.desc             product.desc
    json.url              product.promoturl(current_user)
  end
end
