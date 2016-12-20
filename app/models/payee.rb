class Payee < ActiveRecord::Base
	has_many :transactions
	validates_presence_of :payee
	validates_uniqueness_of :payee
end
