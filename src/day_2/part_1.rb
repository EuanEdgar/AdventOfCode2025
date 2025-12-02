require_relative '../problem'

module Day2
  class Part1 < Problem
    def self.run
      ranges = load_input

      sum = 0
      ranges.each do |range|
        range.each do |value|
          string_value = value.to_s
          if string_value.length % 2 != 0
            next
          end

          first_half = string_value[0..string_value.length / 2 - 1]
          second_half = string_value[string_value.length / 2..]

          if first_half == second_half
            sum += value
          end
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
