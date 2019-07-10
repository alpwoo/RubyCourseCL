class Board
	def initialize
		@board = [[0,0,0], [0,0,0], [0,0,0]]
		@b_map = ["_|_|_", "_|_|_", "_|_|_"]
		@winner = 0
		@PLAYER_CHAR = ['X', 'O']
	end

	def play(row, col, player)
		if (@board[row][col] == 0)
			@board[row][col] = player
			@b_map[row][2*col] = @PLAYER_CHAR[player-1]
			return true
		else
			puts "illegal move, try again!"
			return false
		end
	end

	def check_for_win
		if (@board[0][0] == @board[0][1] && @board[0][1] == @board[0][2])
			@winner = @board[0][0]
		elsif (@board[1][0] == @board[1][1] && @board[1][1] == @board[1][2])
			@winner = @board[1][0]
		elsif (@board[2][0] == @board[2][1] && @board[2][1] == @board[2][2])
			@winner = @board[2][0]
		elsif (@board[0][0] == @board[1][0] && @board[1][0] == @board[2][0])
			@winner = @board[0][0]
		elsif (@board[0][1] == @board[1][1] && @board[1][1] == @board[2][1])
			@winner = @board[0][1]
		elsif (@board[0][2] == @board[1][2] && @board[1][2] == @board[2][2])
			@winner = @board[0][2]
		elsif (@board[0][0] == @board[1][1] && @board[1][1] == @board[2][2])
			@winner = @board[0][0]
		elsif (@board[2][0] == @board[1][1] && @board[1][1] == @board[0][2])
			@winner = @board[2][0]
		end
		@winner
	end

	def check_for_draw 
		if @board[0].any?(0) || @board[1].any?(0) || @board[2].any?(0)
			return false
		else
			return true
		end
	end

	def display
		puts @b_map[0]
		puts @b_map[1]
		puts @b_map[2]
	end
end

board = Board.new

winner = 0
player = 1

while winner == 0
	puts "Player #{player} pick a row (0-2): "
	row = gets.chomp.to_i
	
	puts "Player #{player} pick a column (0-2): "
	col = gets.chomp.to_i

	if board.play(row, col, player) == false
		next
	end

	board.display

	if (winner = board.check_for_win) == 0
		if board.check_for_draw
			winner = 3
		end
	end
	
	if player == 1
		player = 2
	else
		player = 1
	end
end

if winner == 3
  puts "It's a draw"
else
  puts "Player #{winner} won!"
end
