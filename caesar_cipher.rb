def caesar_cipher (astring, anumber)
	nstring = ""
	astring.each_byte do |x|
		if (x < 123 && x > 96)
			#lowercase
			maxnumber = 122
		elsif (x < 90 && x > 64)
			#uppercase
			maxnumber = 90
		else
			#not a letter
			maxnumber = 0
		end

		if (maxnumber != 0)
			if (x + anumber) <= maxnumber
				x = x + anumber
			else
				x = x + anumber - 25
			end
		end
		nstring = nstring + x.chr
	end
	nstring
end

puts "Enter a string:"
istring = gets.chomp
puts "Enter a shift count (0-25):"
inumber = gets.chomp.to_i
ostring = caesar_cipher istring, inumber
puts "Encrypted string: " + ostring

