class Member < ApplicationRecord
	self.table_name = 'MEMBERS'
	self.primary_key = 'member_id'
	has_many :member_groups
	has_many :member_topics
	has_many :topics, through: :member_topics
	has_many :groups, through: :member_groups
end