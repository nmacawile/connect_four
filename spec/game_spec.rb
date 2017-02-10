require_relative "spec_helper"

describe Game do
	subject { Game.new(HumanPlayer, "P1", HumanPlayer, "P2") }

	before do
		allow(subject).to receive(:puts)
		allow(subject).to receive(:print)
		allow(subject.current_player).to receive(:print)
	end

	describe "#new" do
		it "creates Player objects from the parameters" do
			expect(subject.players[0].class).to be < Player
			expect(subject.players[1].class).to be < Player
		end

		it "initializes with an empty board" do
			expect(subject.board).to be_an_instance_of Board
			expect(subject.board).to be_empty
		end

		it "initializes the draw count to zero" do
			expect(subject.draws).to eq 0
		end

		it "gives the first player the first turn by default" do
			expect(subject.current_player).to be subject.players[0]
		end
	end

	describe "#turn" do
		context "with a valid column index" do
			it "lets the player with the turn to drop a disc into the board" do
				allow(subject).to receive(:loop).and_yield
				allow(subject.current_player).to receive_message_chain(:gets, :to_i).and_return(5)
				subject.turn
				expect(subject.board[4].last).to eq subject.current_player.disc
				expect(subject.board[4].size).to eq 1
			end
		end
		context "with an invalid column index" do
			it "doesn't drop a disc into the board" do
				allow(subject).to receive(:loop).and_yield
				allow(subject.current_player).to receive_message_chain(:gets, :to_i).and_return(15)
				expect { subject.turn }.not_to change { subject.board }
			end
		end
	end

	describe "#switch" do
		it "switches to the other player" do
			subject.switch
			expect(subject.current_player).to be subject.players[1]
		end
	end

	describe "#switch_first_turn" do
		it "gives the other player the first turn" do
			subject.switch_first_turn
			expect(subject.first_turn).to eq 1
			expect(subject.current_player).to be subject.players[1]
		end
	end

	describe "#over?" do
		context "game is over" do
			
			context "there is a winner" do
				before do
					4.times { |c| subject.board.drop(c, subject.current_player.disc) }
				end

				it "adds a point to the winner" do
					subject.over?
					expect(subject.current_player.score).to eq 1
				end

				it "returns true" do
					expect(subject.over?).to be true
				end
			end

			context "the board is full" do
				before do
					char = :a
					7.times do |c|
						6.times do |r|
							subject.board.drop(c, char)
							char = char.next
						end
					end
				end

				it "adds a point to draws" do
					subject.over?
					expect(subject.draws).to eq 1
				end

				it "returns true" do
					expect(subject.win?).to be false
					expect(subject.full?).to be true
				end
			end			
		end

		context "game is not yet over" do
			it "returns false" do
				expect(subject.over?).to be false
			end
		end
	end	
end