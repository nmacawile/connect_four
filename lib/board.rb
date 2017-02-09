class Board < Array
	def initialize
		super(7) { [] }
	end

	def empty?
		all? { |column| column.empty? }
	end

	def full?
		all? { |column| column.size == 6 }
	end

	def drop(column, disc)
		return false unless column.between?(0, 6)
		if self[column].size < 6
			self[column] << disc
			true
		else
			false
		end
	end

	def winner
		scan_h ||
		scan_v ||
		scan_d_r ||
		scan_d_l
	end

	def straight(outer, inner)
		outer.times do |y|
			prev = nil
			count = 0
			inner.times do |x|
				if yield(x, y) == prev
					count += 1
					return prev if !prev.nil? && count == 4
				else
					prev = yield(x, y)
					count = 1
				end
			end
		end
		nil
	end

	def scan_h
		straight(6, 7) { |column, row| self[column][row] }
	end

	def scan_v
		straight(7, 6) { |row, column| self[column][row] }
	end

	def diagonal(range)
		4.times do |column|
			range.each do |row|
				prev = self[column][row]
				count = 0
				4.times do |n|
					if self[column + n][yield(row, n)] == prev && !prev.nil?
						count += 1
						return prev if count == 4
					else
						break
					end
				end
			end

		end
		nil
	end

	def scan_d_r
		diagonal(0..2) { |row, n| row + n }
	end

	def scan_d_l
		diagonal(3..5) { |row, n| row - n }
	end
end