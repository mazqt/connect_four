require_relative '../lib/board.rb'
require_relative '../lib/player.rb'
require_relative '../lib/game.rb'

describe Player do
  describe "#initialize" do
    context "when fed a symbol" do
      subject(:player) { described_class.new(:J) }

      it "makes a player instance with that symbol as a mark" do
        expect(player.mark).to eq(:J)
      end
    end
  end
end

describe Board do
  describe "#initialize" do
    context "when a board is initialized" do
      subject(:new_board) { described_class.new }

      it "creates an array containing 7 arrays of length 6" do
        expect(new_board.rows.length).to eq(7)
        expect(new_board.rows[0].length).to eq(6)
      end
    end
  end

  describe "#row_full?" do
    context "when a row is not full" do
      subject(:fresh_board) { described_class.new }

      it "returns false" do
        result = fresh_board.row_full?(0)
        expect(result).to eq(false)
      end
    end

    context "when a row is full" do
      subject(:full_board) { described_class.new }

      before do
        full_rows = Array.new(7) { Array.new(6, :J) }
        full_board.instance_variable_set(:@rows, full_rows)
      end

      it "returns true" do
        result = full_board.row_full?(0)
        expect(result).to eq(true)
      end
    end
  end

  describe "#place_mark" do
    context "when a row is empty" do
      subject(:fresh_board) { described_class.new }

      before do
        fresh_board.place_mark(0, :J)
      end

      it "places a mark at the last index position in the chosen row" do
        result = fresh_board.rows[0][-1]
        expect(result).to eq(:J)
      end
    end

    context "when a row already has marks" do
      subject(:partial_board) { described_class.new }

      before do
        partial_board.place_mark(0, :J)
        partial_board.place_mark(0, :J)
      end

      it "places a mark at the last empty index position" do
        result = partial_board.rows[0][-2]
        expect(result).to eq(:J)
      end
    end

    context "when a row is full" do
      subject(:full_board) { described_class.new }

      before do
        6.times { full_board.place_mark(0, :J) }
      end

      it "doesn't place a mark" do
        result = full_board.place_mark(0, :J)
        expect(result).to eq(false)
      end
    end
  end

end
