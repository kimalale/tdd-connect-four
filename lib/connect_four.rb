class ConnectFour
  attr_accessor :board, :current_player, :game_state, :message
  def initialize(rows = 6, cols = 7)
    @rows = rows
    @cols = cols
    @board = create_board(rows, cols)
    @current_player = 0
    @game_state = true
    @message = nil
    @log_message = nil
  end

  def create_board(rows, cols)
    board = Array.new(rows) { Array.new(cols) { nil } }
    board
  end

  # Returns true if the specified col still has space in the board
  def is_column_not_full?(column)
    is_not_full = false
    row = @rows - 1 # starting from the bottom row
    until row < 0 do
      is_not_full = yield @board[row][column]
      break if is_not_full
      row = row - 1
    end
    is_not_full
  end

  #Place the player's ball at the specified column
  def place_ball(col)
    @log_message = "Column #{col} is full" if !is_column_not_full?(col) { |row | row.nil? } # check if column is empty
    return if @log_message

    to_break = false # keep checking if column is empty before changing it
    row = @rows - 1 # total rows of board
    until row < 0 do
      to_break = true if @board[row][col].nil?
      @board[row][col] = @current_player if @board[row][col].nil?
      break if to_break # stop the loop after finding empty space and assigning/placing the player
      row -= 1
    end
  end

  # Return a symbol representation of the current player
  def entity_character(entity_value)
    entity_symbol = nil

    if entity_value == 0
      entity_symbol = "\u25CF" # Black circle
    elsif entity_value == 1
        entity_symbol = "\u25CB" # White circle
    else
        entity_symbol = " "
    end

      return entity_symbol
  end

  # Display the state of the game
  def show_board
    system('cls')
    puts "Connect Four - Player #{self.entity_character(@current_player)}"
    puts "<< Note - #{@log_message} >>" if @log_message
    @board.each do |valueline|
      valueline.each do | value |
        entity = self.entity_character(value)
        print " #{entity} "
      end
      puts ""
    end

    @log_message = nil if @log_message
  end

  def board_contains?(board)
    it_contains = false

    @board.each do | cols |
      cols.each do | col |
        it_contains = yield col
        break if !it_contains
      end
    end
    it_contains
  end

  def check_win
    @message =  if self.game_over  # Check if any of the players win the game
                  "Player #{self.entity_character(@current_player)} wins!"
                elsif board_contains?(@board) { | col | col == 0 || col == 1 }  # Check if the game ends in a tie
                  "Game ends in draw!"
                else
                  nil
                end

    @game_state = false if @message
    self.show_board if @message
    self.turn_player if !@message
  end

  # Check if the player has won the game || the game resulted in a tie
  def game_over
    counter = 0
    # Traverse horizontally
    (@cols - 1).times do |col |
      (@rows - 1).times do |row |
        counter += 1 if @board[col][row] == @current_player
        counter = 0 if @board[col][row] != @current_player
        return true if counter == 4
      end
    end

    counter = 0
    # Traverse vertically
    (@rows - 1).times do |row |
      (@cols - 1).times do |col |
          counter += 1 if @board[col][row] == @current_player
          counter = 0 if @board[col][row] != @current_player
          return true if counter == 4
      end
    end

    does_player_win = false
    # Traverse diagonally (up-right diagonal)
    (3..@rows - 1).each do |row |
      (0..3).each do |col |
        does_player_win = @board[row][col] && @board[row - 1][col + 1] && @board[row - 2][col + 2] && @board[row - 3][col + 3]
        return true if does_player_win
      end
    end


    # Traverse diagonally (up-left diagonal)
    (0..2).each do |row |
      (0..3).each do |col |
        does_player_win = @board[row][col] && @board[row + 1][col + 1] && @board[row + 2][col + 2] && @board[row + 3][col + 3]
        return true if does_player_win
      end
    end

    does_player_win
  end


  def turn_player
    @current_player = if @current_player == 0
                          1
                        else
                          0
                        end
  end


end

