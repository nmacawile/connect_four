class Player
	attr_accessor :score
	attr_reader :name, :game, :disc

	def initialize(name, game, disc)
		@name = name
		@game = game
		@score = 0
		@disc = disc
	end
end