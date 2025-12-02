require_relative '../problem'

module Day2
  class Part2 < Problem
    def self.run
      ranges = load_input

      sum = 0
      ranges.each do |range|
        range.each do |value|
          string_value = value.to_s
          length = string_value.length
          invalid = (1..(length / 2)).any? do |i|
            part = string_value[...i]
            rest = string_value[i..]
            false unless rest.length % part.length == 0
            rest.split(part).all? { |s| s.empty? }
          end

          if invalid
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
