class Array
	def wrap_join(char)
		"#{char}#{self.join(char)}#{char}".strip
	end
end