require_relative "spec_helper"

describe Game do
	subject { Game.new(HumanPlayer, "P1", HumanPlayer, "P2") }
	describe "#new" do
		it "has " do
			expect(subject.players[0].class).to be < Player
			expect(subject.players[1].class).to be < Player
		end
	end
end