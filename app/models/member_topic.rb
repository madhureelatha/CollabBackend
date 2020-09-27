require 'composite_primary_keys'
class MemberTopic < ApplicationRecord
	self.table_name = 'MEMBER_TOPICS'
	self.primary_keys = :topic_id,:member_id
	belongs_to :member
	belongs_to :topic
end
