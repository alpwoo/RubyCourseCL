class Array
	def to_h(default=nil)
		Hash[ *inject([]) {|a, value| a.push value, default || yield(value) } ]
	end
end

def substring (words, dictionary_hash)
	words.each do |word|
		dictionary_hash.each do |key, val|
			if word.downcase.include? key.downcase
				dictionary_hash[key] = val + 1
			end
		end
	end
	dictionary_hash
end

puts 'enter some word(s)'
words = gets.chomp
word_array = []

words.downcase.scan(/\w+/) { |word|	word_array.push word }

puts 'enter as many words for the dictionary as you\'d like. When you\'re finished, press enter on an empty line'
array = []
loop do
  input = gets.chomp
  if input == ''
  	break
  end
  	array.push input.to_s
  end

dict_hash = array.to_h(0)

puts "hash after: " + (substring word_array, dict_hash).to_s
