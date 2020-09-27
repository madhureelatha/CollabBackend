class Group < ApplicationRecord
	self.table_name = 'GROUPS'
	self.primary_key = 'group_id'
	belongs_to :category, :class_name=>'Category'
	belongs_to :city
	has_many :group_topics
	has_many :events
	has_many :topics, through: :group_topics
	has_many :members, through: :members
end