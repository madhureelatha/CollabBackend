require 'composite_primary_keys'
class GroupTopic < ApplicationRecord
    self.table_name = 'GROUPS_TOPICS'
    self.primary_keys = :topic_id, :group_id
    belongs_to :group
    belongs_to :topics
end