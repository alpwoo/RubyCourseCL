def check_end_values (stock_array)

	check_again = false
	max_index = stock_array.find_index(stock_array.max)
	min_index = stock_array.find_index(stock_array.min)

	if min_index == stock_array.length - 1
		#last value is lowest
		stock_array.slice!(-1)
		check_again = true
	end
	if max_index == 0
		#first value is highest
		stock_array.slice!(0)
		check_again = true
	end

	if stock_array.length < 2
		check_again = false
	end

	if (check_again)
		check_end_values stock_array
	end

end

def stock_picker (stock_array)

	if stock_array.length < 2
		puts "need at least two stock values"
		return nil
	end

	reduced_array = [].replace stock_array
	check_end_values reduced_array

	if reduced_array.length < 2
		puts "need at least two stock values"
		return nil
	end

	max_index = stock_array.find_index(reduced_array.max)
	min_index = stock_array.find_index(reduced_array.min)

	if (min_index >= max_index)
		reduced_array = [].replace stock_array
		reduced_array.slice!(0, min_index)
		max_index = stock_array.find_index(reduced_array.max)
	end
	puts "buy on day " + min_index.to_s + ", sell on day " + max_index.to_s

end

puts 'enter as many stock prices as you\'d like. When you\'re finished, press enter on an empty line'
array = []
loop do
  input = gets.chomp
  if input == ''
  	break
  end
  	array.push input.to_f
end

stock_picker array






