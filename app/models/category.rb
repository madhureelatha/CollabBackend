class Category < ApplicationRecord
	self.table_name = 'CATEGORIES'
	self.primary_key = 'category_id'
	has_many :groups, :foreign_key=>'category_id',:class_name=>'Group'
end