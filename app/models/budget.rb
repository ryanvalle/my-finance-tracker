class Budget < ActiveRecord::Base
	has_many :transactions
	validates_uniqueness_of :budget
end
