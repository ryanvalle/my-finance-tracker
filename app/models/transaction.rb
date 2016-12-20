class Transaction < ActiveRecord::Base
	belongs_to :user
	belongs_to :category
	belongs_to :payee
	belongs_to :budget

	def self.get_transactions_by_user user_id, sort='DESC'
		if user = User.find_by_id(user_id)
			user.transactions.order("transaction_on #{sort.upcase}")
		end
	end

	def self.get_transaction_by_user_on_month user_id, month, year, sort='DESC'
		month = Date.new(year, month, 1)
		if user = User.find_by_id(user_id)
			user.transactions.where(transaction_on: (month)..(month+1.month)).order("transaction_on #{sort.upcase}")
		end
	end

	def self.get_total_income data
		total = 0
		data ||= {}
		data.each {|t| total += t.amount if t.income }
		total
	end

	def self.get_total_expense data
		total = 0
		data ||= {}
		data.each {|t| total += t.amount if !t.income }
		total
	end
end
