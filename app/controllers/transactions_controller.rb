class TransactionsController < ApplicationController
	
	def index
		@transactions = Transaction.get_transactions_from_user(@user.id)
	end

	def show
		transaction = Transaction.get_transactions_from_user(@user.id)
		render json: transaction
	end

	def create
 		ts = validate_data(transaction_params, params['transaction'])

		data = Transaction.new(ts)

		if data.save
			render json: { status: 200, message: "Transaction saved", details: data }
		else
			render json: { status: 403, message: "Error saving transaction.", details: data}
		end
		return
	end

	private
	def transaction_params
		 params.require(:transaction).permit(:user_id, :payee_id, :category_id, :description, :amount, :income)
	end

	def validate_data(src, params)
		data = src
		# Validate or Create User...
		data['amount'] = (params['amount'].to_f * 100).to_i
		data['transaction_on'] = params['transaction_on'].to_datetime

		if @user.id == params['user_id'].to_i && @user.cookie == cookies[:user]
			data['user_id'] = @user.id
		else
			render json: { status: 403, message: "Invalid or duplicate username.", request: data}
			return
		end
		# Validate or Create Payee...
		if payee = Payee.find_by_id(params['payee_id'])
			data['payee_id'] = payee.id
		else
			new_payee = params['payee'].try(:downcase)
			payee = Payee.create(payee: new_payee) 
			if payee.save
				data['payee_id'] = payee.id
			else
				if payee = Payee.find_by_payee(new_payee)
					data['payee_id'] = payee.id
				else
					render json: { status: 403, message: "Invalid payee.", request: data}
					return
				end
			end
		end

		# Validate or Create Category
		if category = Category.find_by_id(params['category_id'])
			data['category_id'] = category.id
		else
			new_category = params['category'].try(:downcase)
			category = Category.create(category: new_category) 
			if category.save
				data['category_id'] = category.id
			else
				if category = Category.find_by_category(new_category)
					data['category_id'] = category.id
				else
					render json: { status: 403, message: "Invalid category.", request: data}
					return
				end
			end
		end

		# Validate or Create Budget
		if budget = Budget.find_by_id(params['budget_id'])
			data['budget_id'] = budget.id
		else
			new_budget = params['budget'].try(:downcase)
			budget = Budget.create(budget: new_budget) 
			if budget.save
				data['budget_id'] = budget.id
			else
				if budget = Budget.find_by_budget(new_budget)
					data['budget_id'] = budget.id
				else
					render json: { status: 403, message: "Invalid budget.", request: data}
					return
				end
			end
		end

		return data
	end
end