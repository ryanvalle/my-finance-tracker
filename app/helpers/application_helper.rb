module ApplicationHelper
	def format_currency amount
		"%.2f" % [(amount).round / 100.0]
	end
end
