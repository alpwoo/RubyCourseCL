class Board
	@@COLORS = ['K', 'R', 'G', 'B', 'C', 'Y', 'M']

	def initialize
		@board = ['K', 'K', 'K', 'K']
		@response = ['_', '_', '_', '_']
		@r_map = "_|_|_|_"
		@comp_guess=['_', '_', '_', '_']
		@try_again=['_', '_', '_', '_']
	end

	def secret_code(code = nil)
		if (code == nil)
			@board.map! { |loc| 
			col = rand(0..6)
			loc = @@COLORS[col]}
		else
			ndx = 0
			while ndx < 4
				if (@@COLORS.none?(code[ndx]))
					puts "Invalid selection #{code[ndx]}, using K instead"
					code[ndx] = 'K'
				end
				@board[ndx] = code[ndx]
				ndx += 1
			end
		end 
	end

	def check_code (guess)
		ndx = 0
		right_guesses = 0
		while ndx < 4
			if guess[ndx] == @board[ndx]
				@response[ndx] = guess[ndx]
				right_guesses += 1
			elsif @board.any?(guess[ndx])
				@response[ndx] = "W"
				if (ndx < 3)
					ndx2 = ndx + 1
					found = false
					while ndx2 < 4
						if (@response[ndx2] == '_' && @try_again[ndx2] == '_')
							@try_again[ndx2] = guess[ndx]
							found = true
							break
						end
						ndx2 += 1
					end
					if (!found)
						ndx2 = 0
						while ndx2 < ndx + 1
							if (@response[ndx2] == '_' && @try_again[ndx2] == '_')
								@try_again[ndx2] = guess[ndx]
								found = true
								break
							end
							ndx2 += 1
						end
					end
				else
					ndx2 = 0
					while ndx2 < 4
						if (@response[ndx2] == '_' && @try_again[ndx2] == '_')
							@try_again[ndx2] = guess[ndx]
							break
						end
						ndx2 += 1
					end
				end
			else
				@response[ndx] = '_'
			end
			ndx += 1 
		end

		if (right_guesses == 4)
			return true
		else
			return false
		end
	end

	def display
		ndx = 0
		while ndx < 4
			@r_map[ndx*2] = @response[ndx]
			ndx += 1 
		end
		puts "Response on board: #{@r_map}"
	end

	def computer_guess
		ndx = 0
		while ndx < 4
			if (@response[ndx] == '_')
				if (@try_again[ndx] != '_')
					@comp_guess[ndx] = @try_again[ndx]
				else
					col = rand(0..6)
					@comp_guess[ndx] = @@COLORS[col]
				end
			elsif (@response[ndx] == 'W')
				col = rand(0..6)
				@comp_guess[ndx] = @@COLORS[col]
			else
				@comp_guess[ndx] = @response[ndx]
			end
			ndx += 1
		end
		puts "Computer guessed: #{@comp_guess.to_s}"
		@comp_guess
	end

	def reset_game
		initialize
	end

end

board = Board.new
selection = 'H'

loop do
	guess_cnt = 0
	complete = false

	if (selection == 'H')
		puts "Human is playing"
		board.secret_code

		while (guess_cnt < 12) && !complete
			puts "Available colors: Blac(K) (R)ed (G)reen (B)lue (C)yan (Y)ellow (M)agenta"
			puts "Enter a guess for four colors in a row: "
			guess = gets.chomp.slice(0..3).upcase
			puts "You entered #{guess}"
			complete = board.check_code(guess)
			guess_cnt += 1
			puts "Round #{guess_cnt}"
			board.display
		end
	else
		puts "Computer is playing"
		puts "Available colors: Blac(K) (R)ed (G)reen (B)lue (C)yan (Y)ellow (M)agenta"
		puts "Enter a secret code for four colors in a row: "
		code = gets.chomp.slice(0..3).upcase
		puts "You entered #{code}"
		board.secret_code (code)
		while (guess_cnt < 12) && !complete
			complete = board.check_code(board.computer_guess)
			if !complete
				guess_cnt += 1
			end
			puts "Round #{guess_cnt}"
			board.display
		end
	end

	if guess_cnt == 12
		puts "Too many guesses. Game over!"
	elsif selection == 'H'
		puts "Human won. Game over!"
	else
		puts "Computer won. Game over!"
	end

	board.reset_game
	
	puts "Who's playing? Select (H)uman (C)omputer or (Q)uit: "
	selection = gets.chomp.slice(0).upcase
	break if selection == 'Q'
end