class Board < Array
	def initialize
		super(7) { [] }
	end

	def empty?
		self.all? { |column| column.empty? }
	end

	def full?
		self.all? { |column| column.size == 6 }
	end

	def drop(column, disc)
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

	def scan_h
		6.times do |row|
			prev = nil
			count = 0
			7.times do |column|
				if self[column][row] == prev
					count += 1
					return prev if !prev.nil? && count == 4
				else
					prev = self[column][row]
					count = 1
				end
			end
		end
		nil
	end

	def scan_v
		7.times do |column|
			prev = nil
			count = 0
			6.times do |row|
				if self[column][row] == prev
					count += 1
					return prev if !prev.nil? && count == 4
				else
					prev = self[column][row]
					count = 1
				end
			end
		end
		nil
	end

	def scan_d_r
		4.times do |column|
			3.times do |row|
				prev = self[column][row]
				count = 0
				4.times do |n|
					if self[column + n][row + n] == prev && !prev.nil?
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

	def scan_d_l
		4.times do |column|
			(3..5).each do |row|
				prev = self[column][row]
				count = 0
				4.times do |n|
					if self[column + n][row - n] == prev && !prev.nil?
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

end