class User < ActiveRecord::Base
	has_secure_password
	has_many :transactions
	validates_presence_of :user
	validates_uniqueness_of :user
end
