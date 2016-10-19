json.array! @subordinates do |user|
  json.id                             user.id
  json.name                           user.name
  json.created_date                   user.created_at.strftime("%Y-%m-%d")
  json.status                         (user.status == "激活") ? "true" : "false"
  json.bonus                          (Newbonu.find_by(subordinate_id: user)) ? Newbonu.find_by(subordinate_id: user).bonus : "0"
end
