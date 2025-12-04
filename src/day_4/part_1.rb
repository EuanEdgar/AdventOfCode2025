require_relative '../problem'

module Day4
  BLANK = '.'
  ROLL = '@'

  class Part1 < Problem
    def self.run
      grid = load_input
      grid.sum do |cell|
        if cell.value == BLANK
          0
        else
          roll_neighbours = cell.neighbours.compact.count { |n| n.value == ROLL }
          if roll_neighbours < 4
            1
          else
            0
          end
        end
      end
    end

    def self.parse_input(input)
      Grid.new(input.split("\n").map(&:chars))
    end
  end

  class Cell
    attr_reader :value, :row_index, :column_index, :grid
    def initialize(value, row_index, column_index, grid:)
      @value = value
      @row_index = row_index
      @column_index = column_index
      @grid = grid
    end

    def neighbour(ordinal)
      # 0 1 2
      # 3 X 4
      # 5 6 7

      column = case ordinal
      when 0, 1, 2
        column_index - 1
      when 3, 4
        column_index
      when 5, 6, 7
        column_index + 1
      end

      row = case ordinal
      when 0, 3, 5
        row_index - 1
      when 1, 6
        row_index
      when 2, 4, 7
        row_index + 1
      end

      grid.at(row, column)
    end

    def neighbours
      (0..7).map(&method(:neighbour))
    end

    def row
      grid.row(row_index)
    end

    def column
      grid.column(column_index)
    end
  end

  class Grid
    include Enumerable

    attr_reader :values, :width, :height
    def initialize(values)
      @values = values
      @width = values.first.size
      @height = values.size
    end

    def [](index)
      to_a[index]
    end

    def at(row, column)
      if row < 0 || row >= height || column < 0 || column >= width
        nil
      else
        Cell.new(values[row][column], row, column, grid: self)
      end
    end

    def each
      values.each_with_index do |row, row_index|
        row.each_with_index do |value, column_index|
          yield Cell.new(value, row_index, column_index, grid: self)
        end
      end
    end

    def row(index)
      values[index].map.with_index do |value, column_index|
        Cell.new(value, index, column_index, grid: self)
      end
    end

    def column(index)
      values.map.with_index do |row, row_index|
        Cell.new(row[index], row_index, index, grid: self)
      end
    end
  end
end
