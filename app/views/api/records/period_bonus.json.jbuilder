json.number        @records.count
json.total_sell    @records.sum(:total_prize)
json.bonus         @records.sum(:bonus)
json.commis        @records.sum(:commis)
