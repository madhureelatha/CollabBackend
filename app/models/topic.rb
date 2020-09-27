class Topic < ApplicationRecord
	self.table_name = 'TOPICS'
	self.primary_key = 'topics_id'
	has_many :group_topics
	has_many :member_topics
	has_many :groups, through: :group_topics
	has_many :members, through: :member_topics
end
