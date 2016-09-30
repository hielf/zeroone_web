json.id           @product.id
json.name         @product.name
json.prize        @product.prize
json.image        "http://121.42.36.163" + @product.image.url
json.desc         @product.desc
json.url          @product.promoturl(@current_user)
