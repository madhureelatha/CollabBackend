class Venue < ApplicationRecord
	self.table_name = 'VENUES'
	self.primary_key = 'venue_id'
	has_many :events
end
