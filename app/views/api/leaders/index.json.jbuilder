json.leaders do
  json.partial! 'api/leaders/leader', collection: @leaders, as: :leader
end