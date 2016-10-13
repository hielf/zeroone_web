json.array! @records do |row|
  json.id row[0]
  json.product Product.find(row[1]).name if Product.find(row[1])
  json.total_prize row[2]
  json.total_insured row[3]
  json.policy_no row[4]
  json.start_date row[5]
  json.end_date row[6]
  json.sell_date row[7]
  json.bonus row[8]
  json.commis row[9]
end
