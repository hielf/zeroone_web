json.name filter_name(leader.name)
json.phone filter_phone(leader.phone)
json.state leader.state ? leader.state : ""
json.loan_state leader.loan_state ? leader.loan_state : ""
json.date I18n.l(leader.updated_at.to_date, format: :long)