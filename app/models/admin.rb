class Admin < ActiveRecord::Base
  has_secure_password
  validates :name, presence: true
  HEADERS = ["name", "created_at", "updated_at"]
end
