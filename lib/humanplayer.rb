require_relative 'player'

class HumanPlayer < Player
	def turn
		print "#{name}'s turn: "
		input = gets.to_i
		game.board.drop(input - 1, disc)
	end
end