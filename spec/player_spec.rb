require_relative "spec_helper"

describe Player do
	let(:game) { double("game")}

	subject { Player.new("Player1", game, :red) }

	describe "#new" do
		it "creates a Player object with three parameters" do
			game2 = double
			subject = Player.new("NewPlayer", game2, :yellow)

			is_expected.to be_an_instance_of Player
			expect(subject.game).to be game2
			expect(subject.disc).to eq :yellow		
			expect(subject.name).to eq "NewPlayer"
		end

		it "has an initial score of 0" do
			expect(subject.score).to eq 0
		end
	end
	describe "#score" do
		it "can be incremented" do
			subject.score += 1
			expect(subject.score).to eq 1
		end
	end
end