json.array! @subordinates do |user|
  json.id                             user.id
  json.created_date                   user.created_at.strftime("%Y-%m-%d")
  json.status                         (user.status == "激活") ? "true" : "false"
  json.bonus                          Newbonu.find_by(subordinate_id: user).bonus
end
