require_relative "spec_helper"

describe ComputerPlayer do
	before do
		@board = Board.new
		@game = double
		allow(@game).to receive(:board).and_return(@board)
	end

	subject { ComputerPlayer.new("Computer", @game, :red) }

	describe "#new" do		
		it "inherits from Player class" do
			expect(subject.class).to be < Player
		end
	end

	describe "#turn" do
		context "when there is a valid column" do
			before do
				6.times do |column|
					6.times do
						@board.drop(column, :blue)
					end
				end
			end

			it "drops a disc in a valid, non-full column" do				
				subject.turn
				expect(@board[6].last).to eq :red
			end

			it "returns true" do
				expect(subject.turn).to be true
			end
		end

		context "when there are no valid columns" do
			before do
				7.times do |column|
					6.times do
						@board.drop(column, :blue)
					end
				end
			end

			it "doesn't drop a disc in the board" do
				expect { subject.turn }.not_to change { @board }
			end

			it "returns false" do
				expect(subject.turn).to be false
			end
		end
	end
end