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
    attr_reader :row_index, :column_index, :grid
    def initialize(row_index, column_index, grid:)
      @row_index = row_index
      @column_index = column_index
      @grid = grid
    end

    def value
      grid.values[row_index][column_index]
    end

    def value=(value)
      grid.values[row_index][column_index] = value
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
  end

  class Row
    include Enumerable

    attr_reader :index, :grid
    def initialize(index, grid:)
      @index = index
      @grid = grid
    end

    def [](column_index)
      grid.at(index, column_index)
    end

    def each
      width.times do |column_index|
        yield grid.at(index, column_index)
      end
    end
  end

  class Column
    include Enumerable

    attr_reader :index, :grid
    def initialize(index, grid:)
      @index = index
      @grid = grid
    end

    def [](row_index)
      grid.at(row_index, index)
    end

    def each
      height.times do |row_index|
        yield grid.at(row_index, index)
      end
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
        Cell.new(row, column, grid: self)
      end
    end

    def each
      height.times do |row_index|
        width.times do |column_index|
          yield self.at(row_index, column_index)
        end
      end
    end

    def row(index)
      Row.new(index, grid: self)
    end

    def column(index)
      Column.new(index, grid: self)
    end
  end
end
