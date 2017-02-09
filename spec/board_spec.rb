require_relative "spec_helper"

describe Board do
	subject { Board.new }

	describe "#new" do 
		it "creates an empty board" do
			is_expected.to be_an_instance_of Board
			is_expected.to be_empty
		end
	end

	describe "#drop(column, disc)" do
		context "when column index is invalid" do
			it "doesn't drop a disc into any column" do
				expect { subject.drop(7, :disc) }.not_to change { subject }
			end

			it "returns false" do
				expect(subject.drop(7, :disc)).to be false 
			end
		end

		context "when column is full" do
			before do
				3.times do 
					subject.drop(3, :red)
					subject.drop(3, :yellow)
				end
			end

			it "doesn't drop a disc into the column" do
				subject.drop(3, :disc)
				expect(subject[3].last).to eq :yellow
			end

			it "returns false" do
				expect(subject.drop(3, :disc)).to be false 
			end
		end

		context "when column is not full" do
			before do
				2.times do 
					subject.drop(3, :red)
					subject.drop(3, :yellow)
				end
			end	

			it "drops a disc into the column" do
				subject.drop(3, :disc)
				expect(subject[3].last).to eq :disc
			end

			it "returns true" do
				expect(subject.drop(3, :disc)).to be true
			end
		end
	end

	describe "#full?" do
		context "when board is full" do
			it "returns true" do				
				7.times do |column|
					3.times do
						subject.drop(column, :red)
						subject.drop(column, :yellow)
					end
				end
				expect(subject.full?).to be true
			end
		end

		context "when board is not full" do
			it "returns false" do
				7.times do |column|
					5.times do
						subject.drop(column, :red)
					end
				end
				expect(subject.full?).to be false
			end
		end
	end

	describe "#winner" do
		context "when there is a winner" do
			context "vertical winning condition" do
				it "returns the disc of the winning player" do
					4.times { subject.drop(0, :disc) }
					expect(subject.scan_v).to eq :disc
				end
			end
			context "horizontal winning condition" do
				it "returns the disc of the winning player" do
					4.times { |column| subject.drop(column, :disc) }
					expect(subject.scan_h).to eq :disc
				end
			end
			context "diagonal winning condition (right)" do
				it "returns the disc of the winning player" do
					4.times do |n|
						(n + 1).times do |m|
							n == m ? subject.drop(n, :disc) : subject.drop(n, :red)
						end
					end
					expect(subject.scan_d_r).to eq :disc
				end
			end
			context "diagonal winning condition (left)" do
				it "returns the disc of the winning player" do
					3.downto(0) do |n|
						(n + 1).times do |m|
							n == m ? subject.drop(m, :disc) : subject.drop(m, :red)
						end
					end
					expect(subject.scan_d_l).to eq :disc
				end
			end
		end
		context "when there is no winner" do 
			it "returns nothing" do
				expect(subject.winner).to be nil
			end
		end
	end
end