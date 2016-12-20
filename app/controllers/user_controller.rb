class UserController < ApplicationController
	skip_before_filter :validate_authentication
	def login
		@user = User.new()
	end

	def new
		@user = User.new()
	end

	def auth
		user_params = params[:user]
		user = User.find_by_user(user_params[:user])
		if user && user.authenticate(user_params[:password])
			create_session(user)
			redirect_to ui_trans_path
		else
			flash[:notice] = 'Invalid login...'
			redirect_to user_login_path
		end
	end

	def create
		user = User.new(user_params)
		cookie = SecureRandom.hex(12)
		if user.save
			create_session(user)
			redirect_to ui_trans_path
		else
			flash[:notice] = 'Failed to create user...'
			redirect_to user_login_path
		end
	end

	private
	def user_params
		params.require(:user).permit(:user, :password, :password_confirmation)
	end

	def create_session(user)
		user.cookie = SecureRandom.hex(12)
		user.save
		session[:current_user] = user.id
		cookies[:user] = {
			value: user.cookie,
			expires_in: 1.hour.from_now
		}
	end
end