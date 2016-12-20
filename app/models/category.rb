class Category < ActiveRecord::Base
	has_many :transactions
	validates_presence_of :category
	validates_uniqueness_of :category
end
