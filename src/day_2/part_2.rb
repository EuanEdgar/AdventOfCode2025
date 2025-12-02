require_relative '../problem'

module Day2
  class Part2 < Problem
    REGEX = /^(\d+)\1+$/

    def self.run
      ranges = load_input

      sum = 0
      ranges.each do |range|
        range.each do |value|
          string_value = value.to_s
          sum += value if string_value.match?(REGEX)
        end
      end

      sum
    end

    def self.parse_input(input)
      input.split(",").map do |range|
        Range.new(*range.split("-").map(&:to_i))
      end
    end
  end
end
