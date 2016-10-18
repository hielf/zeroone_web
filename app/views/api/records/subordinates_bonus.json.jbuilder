json.array! @subordinates do |user|
  json.id                             user.id
  json.create_date                    user.create_date.strftime("%Y-%m-%d")
  json.status                         (user.status == "激活") ? "true" : "false"
  json.bonus                          Newbonu.find_by(subordinate_id: user).bonus
end
