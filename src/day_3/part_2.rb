require 'pry'
require_relative '../problem'

module Day3
  class Part2 < Problem
    NUM_DIGITS = 12

    def self.run
      grid = load_input

      grid.sum do |row|
        Array.new(NUM_DIGITS).each_with_index.each_with_object(Struct.new(:values, :last_index).new([], -1)) do |(value, index), acc|
          min_index = acc.last_index + 1
          list = row[min_index..-(NUM_DIGITS - index)]

          max_value, max_index = list.each_with_index.max_by { |value, index| value }
          acc.values << max_value
          acc.last_index = max_index + min_index
        end.values.join.to_i
      end
    end

    def self.parse_input(input)
      input.split("\n").map { |l| l.chars.map(&:to_i) }
    end
  end
end
