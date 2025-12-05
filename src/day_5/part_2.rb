require_relative './part_1'

module Day5
  class Part2 < Part1
    def self.run
      data = load_input
      ranges = compact_ranges(data.ranges)

      ranges.sum(&:size)
    end
  end
end
