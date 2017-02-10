require_relative "board"
require_relative "humanplayer"
require_relative "computerplayer"
require_relative "helper"
require "colorize"

class Game
	attr_accessor :players, :board, :current_player, :draws, :index, :first_turn

	def initialize(p1class, p1name, p2class, p2name)
		@players = [p1class.new(p1name.colorize(:red), self, "\u25cf".colorize(:red)),
					p2class.new(p2name.colorize(:yellow), self, "\u25cf".colorize(:yellow))]
		@board = Board.new
		@draws = 0
		@index = 0
		@first = 0
		@current_player = players[0]
	end

	def play
		loop do
			show_board
			loop do
				turn
				show_board
				break if over?
				switch
			end
			show_scores
			print "Press [ENTER] (without any text) to play again :"
			input = gets.chomp
			break if input != ""
			self.board = Board.new
			switch_first_turn
		end
	end

	def show_board
		v_ = "\n+---+---+---+---+---+---+---+\n"
		h_ = " | "

		grid = 5.downto(0).map do |row|
			((0..6).map do |column|
				board[column][row].nil? ? "\u25cb".colorize(:light_black) : board[column][row]
			end).wrap_join(h_)
		end.wrap_join(v_)
		puts grid
		puts "  " + ((1..7).map { |n| "#{n}   ".colorize(:light_black) }.join)
	end

	def show_scores
		puts players.map { |player| "#{player.name}: #{player.score}" }.join "\n"
		puts "Draws: #{draws}" if draws > 0
	end

	def turn
		loop do
			break if current_player.turn
			puts "Invalid turn"
		end
	end

	def switch
		self.index = index == 1 ? 0 : 1
		self.current_player = players[index]
	end

	def switch_first_turn
		self.first_turn = first_turn == 1 ? 0 : 1
		self.index = first_turn
		self.current_player = players[index]
	end

	def over?
		win? || full?
	end

	def win?
		if board.winner
			players.each_with_index do |player, i| 
				if player.disc == board.winner
					self.players[i].score += 1 
					puts "#{players[i].name} wins!"	
				end	
			end
			true
		else
			false
		end
	end

	def full?
		if board.full?
			puts "It's a draw!"
			self.draws += 1
			true
		else
			false
		end
	end
end