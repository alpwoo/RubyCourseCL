def bubble_sort (array)
	n = array.length 
	until n <= 1 do
		new_n = 0
		for i in 1..n-1 do
			if (array[i-1] > array[i])
				array[i-1], array[i] = array[i], array[i-1]
				new_n = i
			end
		end
		n = new_n
	end
	array
end

puts (bubble_sort([4,3,78,2,0,2])).to_s

def bubble_sort_by (array) 
		n = array.length 
	until n <= 1 do
		new_n = 0
		for i in 1..n-1 do
			if (yield(array[i-1], array[i]))
				array[i-1], array[i] = array[i], array[i-1]
				new_n = i
			end
		end
		n = new_n
	end
	array
end

puts (bubble_sort_by(["hi","hello","hey"]) {|left, right| left.length > right.length}).to_s

