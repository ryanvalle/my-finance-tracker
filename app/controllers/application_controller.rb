class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :validate_authentication

  before_filter \
  	:set_navigation,
  	:set_months

  def validate_authentication
    if !cookies[:user].present?
      redirect_to user_login_path
    else
      user = User.find_by_id(session[:current_user])
      if user.cookie == cookies[:user]
        @authenticated = true
        @user = user
      else
        session[:current_user] = nil
        cookies[:user] = nil
        user.cookie = nil
        user.save
        flash[:notice] = "Logged out of session..."
        redirect_to user_login_path
      end
    end
  end

  def set_navigation
  	@navigation = %w(
			transactions
			bills
			budgets
			analytics
			add
		)
  end

  def set_months
  	@months = [
      ["Select a Month", nil],
  		%w(1-January 1),
  		%w(2-February 2),
  		%w(3-March 3),
  		%w(4-April 4),
  		%w(5-May 5),
  		%w(6-June 6),
  		%w(7-July 7),
  		%w(8-August 8),
  		%w(9-September 9),
  		%w(10-October 10),
  		%w(11-November 11),
  		%w(12-December 12)
  	]
  end
end
