require_relative 'player'

class ComputerPlayer < Player
	def turn
		validmoves = []
		game.board.each_with_index do |column, index|
			validmoves << index unless column.size == 6
		end		
		validmoves.empty? ? false : game.board.drop(validmoves.sample, disc)
	end
end