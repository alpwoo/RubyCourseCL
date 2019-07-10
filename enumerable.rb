module Enumerable
	def my_each
		for item in self
			yield(item)
		end
	end
	def my_each_with_index
		ndx = 0
		for item in self
			yield(item, ndx)
			ndx += 1
		end
	end
	def my_select
		new_array = []
		for item in self
			if (yield(item))
				new_array.push(item)
			end
		end
		new_array
	end
	def my_all?
		state = true
		for item in self
			state &&= yield(item)
		end
		state
	end
	def my_any?
		state = false
		for item in self
			state ||= yield(item)
		end
		state
	end
	def my_none?
		state = false
		for item in self
			state ||= yield(item)
		end
		!state
	end
	def my_count
		cnt = 0
		for item in self
			if yield(item)
				cnt += 1
			end
		end
		cnt
	end
	def my_map
		new_array = []
		for item in self
			new_array.push(yield(item))
		end
		new_array
	end
	def my_inject (val, &block)
		for item in self
			val = block.call(val, item)
		end
		val
	end
end

array = [1, 2, 3]

array.my_each {|item| puts item.to_s}
array.my_each_with_index {|item, ndx| puts ndx.to_s + ": " + item.to_s}
puts (array.my_select {|item| item > 1}).to_s
puts (array.my_all? {|item| item > 1}).to_s
puts (array.my_any? {|item| item > 3}).to_s
puts (array.my_none? {|item| item > 2}).to_s
puts (array.my_count {|item| item > 0}).to_s
puts (array.my_map {|item| 2*item}).to_s
puts(array.my_inject(1) {|val, item|	val * item}).to_s
