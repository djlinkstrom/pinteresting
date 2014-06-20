module ApplicationHelper

	def nice_date_form(the_date)
	   return the_date.strftime('%m/%d/%Y %I:%M %p')
	end
	
end
