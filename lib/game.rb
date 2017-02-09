require_relative "board"
require_relative "humanplayer"
require_relative "computerplayer"

class Game
	attr_accessor :players, :board, :current_player, :draws

	def initialize(p1class, p1name, p2class, p2name)
		@players = [p1class.new(p1name, self, "O"), p2class.new(p2name, self, "X")]
		@board = Board.new
		@draws = 0
		@current_player = players[0]
	end

	def turn
		loop do
			break unless current_player.turn
			puts "invalid turn"
		end
	end

	def over?
		win? || full?
	end

	def win?
		if board.winner
			players.each do |player| 
				player.score += 1 if player.disc == board.winner
				puts "#{current_player.name} wins!"
				return true
			end
		end
		false
	end

	def full?
		if board.full?
			puts "It's a draw!"
			self.draws += 1
			return true
		end
		false
	end
end