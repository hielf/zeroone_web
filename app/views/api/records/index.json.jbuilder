json.records do
  json.array! @records do |record|
    json.id               record.id
    json.product          record.product.name if record.product
    json.total_prize      record.total_prize
    json.policy_no        record.policy_no
    json.sell_date        record.sell_date
    json.start_date       record.start_date
    json.end_date         record.end_date
    json.bonus            record.bonus
    json.commis           record.commis
  end
end
