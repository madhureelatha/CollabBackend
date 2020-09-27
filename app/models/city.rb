class City < ApplicationRecord
	self.table_name = 'CITIES'
	self.primary_key = 'city_id'
	has_many :groups
end
