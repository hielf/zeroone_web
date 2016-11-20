if @product
  json.id           @product.id
  json.name         @product.name
  json.prize        @product.prize
  json.image        @product.image.url ? "http://121.42.36.163" + @product.image.url : nil
  json.desc         @product.desc
  json.url          @product.promoturl(@current_user)
  json.type         @product.product_type
end
