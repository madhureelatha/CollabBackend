class Event < ApplicationRecord
    self.table_name = 'EVENTS'
    self.primary_key = 'event_id'
    belongs_to :group
    belongs_to  :venue
end
