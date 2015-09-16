class Board
	attr_reader :grid

	def initialize(content)
		@grid = {}
		[*"A".."J"].each do |l|
			[*1..10].each {|n| @grid["#{l}#{n}".to_sym] = content.new}
		end
	end

	def place(ship, coord, orientation = :horizontally)
		coords = [coord]
		(ship.size - 1).times{coords << next_coord(coords.last, orientation)}
		put_on_grid_if_possible(coords, ship)
	end

	def floating_ships?
		ships.any?(&:floating?)
	end

	def shoot_at(coordinate)
		raise "You cannot hit the same square twice" if  grid[coordinate].hit?
		grid[coordinate].shoot
	end

	def ships
		grid.values.select{|cell|is_a_ship?(cell)}.map(&:content).uniq
	end

	def ships_count
		ships.count
	end

	def print_board
		printed_board = "<div style='height:50px; width:550px;'>"
		[*"A".."J"].each do |l| #iterate through letters
			[*1..10].each do |n|#iterate through numbers
				if grid["#{l}#{n}".to_sym].content.is_a?(Water) #any letter, number as symbol eg :A1 rather than A1 is water etc...
					printed_board += "<div style='background-color:#0000FF; height:50px; width:50px; display:inline-block; border: 2px dashed red;'> </div>"
				elsif grid["#{l}#{n}".to_sym].content.is_a?(Ship)
					printed_board += "<div style='background-color:#008800; height:50px; width:50px; display:inline-block; border: 2px dashed red;'> </div>"
				end
			end
		end
		printed_board += "</div>"
		printed_board
	end

	def say_hello
	p "Hello - this is the board speaking"

	end

private

 	def next_coord(coord, orientation)
		orientation == :vertically ? next_vertical(coord) : coord.next
	end

	def next_vertical(coord)
		coord.to_s.reverse.next.reverse.to_sym
	end

	def is_a_ship?(cell)
		cell.content.respond_to?(:sunk?)
	end

	def any_coord_not_on_grid?(coords)
		(grid.keys & coords) != coords
	end

	def any_coord_is_already_a_ship?(coords)
		coords.any?{|coord| is_a_ship?(grid[coord])}
	end

	def raise_errors_if_cant_place_ship(coords)
		raise "You cannot place a ship outside of the grid" if any_coord_not_on_grid?(coords)
		raise "You cannot place a ship on another ship" if any_coord_is_already_a_ship?(coords)
	end

	def put_on_grid_if_possible(coords, ship)
		raise_errors_if_cant_place_ship(coords)
		coords.each{|coord|grid[coord].content = ship}
	end

end
