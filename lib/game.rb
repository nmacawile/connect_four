require_relative "board"

class Game
	attr_accessor :players

	def initialize(p1class, p1name, p2class, p2name)
		@players = [p1class.new(p1name), p2class.new(p2name)]
	end

end