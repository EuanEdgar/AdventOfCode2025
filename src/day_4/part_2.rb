require_relative './part_1'

module Day4
  class Part2 < Problem
    def self.run
      grid = load_input

      removed_count = 0
      while cells = removable_cells(grid)
        removed_count += cells.size
        cells.each do |cell|
          grid.values[cell.row_index][cell.column_index] = BLANK
        end
      end

      removed_count
    end

    def self.removable_cells(grid)
      cells = grid.select do |cell|
        cell.value == ROLL &&
          cell.neighbours.compact.count { |n| n.value == ROLL } < 4
      end

      cells.size > 0 ? cells : nil
    end

    def self.parse_input(input)
      Grid.new(input.split("\n").map(&:chars))
    end
  end
end
