require_relative "spec_helper"

describe HumanPlayer do
	before do 
		@game = double
		@board = Board.new
		allow(@game).to receive(:board).and_return(@board)
	end

	subject { HumanPlayer.new("Hooman", @game, :red) }

	describe "#new" do		
		it "inherits from Player class" do
			expect(subject.class).to be < Player
		end
	end

	describe "#turn" do
		context "when column index is valid" do
			it "drops a disc in the selected column" do
				allow(subject).to receive_message_chain(:gets, :to_i).and_return(7)
				expect(subject.turn).to be true
				expect(@board[6].last).to eq :red
			end
		end

		context "when column index is invalid" do
			it "drops a disc in the selected column" do
				allow(subject).to receive_message_chain(:gets, :to_i).and_return(8)
				expect(subject.turn).to be false
			end
		end
	end
end