class CustomFormBuilder < ActionView::Helpers::FormBuilder 

	def username(method, options={}, html_options={}) 
		("<u>" + text_field(method, options) + "</u>" ).html_safe 
	end

end
