class Game
  def initialize(player_1, player_2)
    @player_1 = Player.new(player_1)
    @player_2 = Player.new(player_2)
    @board = Board.new
  end

  def play
    current_player = @player_1

    loop do
      @board.print_board
      move = -1
      until move >= 0 && move <= 6
        puts "#{current_player.mark}, which column do you want to drop your mark into"
        move = gets.chomp
        if move.to_i.to_s != move
          puts "Input a number, not string or symbol"
          move = 9
        else
          move = move.to_i
        end
      end
      @board.place_mark(move, current_player.mark)
      if @board.draw?
        puts "It's a draw!"
        break
      end
      if @board.win?
        puts "#{current_player.mark} wins!"
        break
      end
      if current_player == @player_1
        current_player = @player_2
      else
        current_player = @player_1
      end
    end


  end

end
