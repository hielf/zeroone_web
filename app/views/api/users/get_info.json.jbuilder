json.user do
  json.avatar_thumb @user.avatar_url(:thumb)
  json.(@user, :number, :name, :cell, :email, :id_card, :bank_card, :alipay, :channel)
end