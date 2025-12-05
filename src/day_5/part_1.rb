require_relative '../problem'

module Day5
  class Part1 < Problem
    def self.run
      data = load_input
      ranges = compact_ranges(data.ranges)

      data.ids.count { |id| ranges.any? { |range| range.include?(id) } }
    end

    def self.compact_ranges(ranges)
      ranges = ranges.sort_by(&:min)

      ranges[1..].reduce(ranges[0..0]) do |ranges, range|
        previous = ranges.last

        if previous.max >= range.min
          ranges.pop
          ranges.push(Range.new(previous.min, [range.max, previous.max].max))
        else
          ranges.push(range)
        end

        ranges
      end
    end

    def self.parse_input(input)
      ranges, ids = input.split("\n\n").map do |section|
        section.split("\n")
      end

      Struct.new(:ranges, :ids).new(
        ranges.map { |line| Range.new(*line.split("-").map(&:to_i)) },
        ids.map(&:to_i)
      )
    end
  end
end
