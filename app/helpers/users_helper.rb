module UsersHelper
	def underline(text, options={}, html_options={}) 
		("<u>" + text + "</u>" ).html_safe 
	end
end
