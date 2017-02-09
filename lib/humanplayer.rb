class HumanPlayer < Player
	def turn
		input = gets.to_i
		game.board.drop(input, disc)
	end
end