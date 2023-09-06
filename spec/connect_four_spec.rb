require_relative '../lib/connect_four'

describe ConnectFour do

  describe '#initialize' do

    subject(:connect_four) { described_class.new(6, 7) }

    context 'when board is configured' do
      it 'should initialize the board' do
        board = connect_four.instance_variable_get(:@board)
        expect(board.length).to eq (6)
        expect(board[0].length).to eq (7)
      end
    end
  end

  describe '#check_win' do

    let(:game) { described_class.new }

    before do
      moves = [0, 5, 0, 4, 0, 3, 0]

      moves.each do |column|
        game.place_ball(column)
        game.check_win
      end

    end

    context 'when alligns with the player balls' do
      it 'should check if player wins' do
        current_player = game.entity_character(game.current_player)
        message = "Player #{current_player} wins!"
        received_message = game.message
        expect(received_message).to eq(message)
      end
    end



    context 'when none of the player balls align' do
      let(:draw_game) {described_class.new}

      before do
        # Draw form of the game
        board = [
                [0, 0, 1, 1, 0, 0, 0],
                [0, 1, 1, 0, 0, 1, 0],
                [1, 1, 0, 1, 0, 1, 1],
                [0, 1, 0, 0, 1, 1, 1],
                [1, 0, 1, 0, 1, 0, 0],
                [0, 1, 0, 0, 0, 1, 1]
                ]
          draw_game.board = board
          draw_game.check_win
        end

      xit 'should check if none of the players win' do
        message = "Game ends in draw!"
        received_message = draw_game.message
        expect(received_message).to eq(message)
      end
    end
  end


end
