require_relative '../problem'

module Day3
  class Part1 < Problem
    def self.run
      grid = load_input

      grid.sum do |row|
        max_non_last, index = row[...-1].each_with_index.max_by { |value, index| value }
        max_later = row[(index+1)..].max

        "#{max_non_last}#{max_later}".to_i
      end
    end

    def self.parse_input(input)
      input.split("\n").map { |l| l.chars.map(&:to_i) }
    end
  end
end
