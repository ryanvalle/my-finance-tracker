class UiController < ApplicationController
	def home
	end

	def transactions
		@month_selected = params[:month].present? ? params[:month].to_i : 0
		@year_selected = params[:year].present? ? params[:year].to_i : 0
		@transactions = if @month_selected > 0 && @year_selected > 0
			Transaction.get_transaction_by_user_on_month(@user.id, @month_selected, @year_selected) || {}
		else
			Transaction.get_transactions_by_user(@user.id) || {}
		end

		income = Transaction.get_total_income(@transactions)
		expense = Transaction.get_total_expense(@transactions)
		@stats = {
			income: income,
			expense: expense, 
			total: income - expense
		}
		graph_total = income.to_f + expense.to_f

		@graph = {
			income: (income / graph_total) * 100,
			expense: (expense / graph_total) * 100
		}

	end

	def add
		@add_transaction = Transaction.new()
		@categories = Category.all().map {|cat| cat.category}.compact
		@payees = Payee.all().map{|pay| pay.payee}.compact
		@budgets = Budget.all().map{|b| b.budget}.compact
		@timenow = Time.now.strftime('%Y-%m-%dT%H:%M')
		@transactions = Transaction.get_transactions_by_user(@user.id).try(:limit,10) || {}
	end
end