require 'composite_primary_keys'
class MemberGroup < ApplicationRecord
	self.table_name = 'MEMBER_GROUPS'
	self.primary_key = 'member_id',"group_id"
	belongs_to :group
	belongs_to :member
end
