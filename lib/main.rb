require_relative "game"

puts "CONNECT4"
puts 
puts "Choose game mode:"
puts "[1] 1P (vs Computer)"
puts "[2] 2P (vs Human)"
puts "[3] Demo (Computer vs Computer)"
puts "[0] Quit"
puts ""



print "game mode > "
input = gets.to_i
p1 = nil
p2 = nil

case input
when 1
	p1 = HumanPlayer
	p2 = ComputerPlayer
when 2
	p1 = HumanPlayer
	p2 = HumanPlayer
when 3
	p1 = ComputerPlayer
	p2 = ComputerPlayer
else
	exit
end


def set_name(pclass, def_name)
	if pclass == HumanPlayer
		puts "#{def_name}, please enter your name"
		input = gets.chomp
		input != "" ? input : def_name
	else
		def_name
	end
end

p1name = set_name(p1, "Player1")
p2name = set_name(p2, "Player2")

Game.new(p1, p1name, p2, p2name).play