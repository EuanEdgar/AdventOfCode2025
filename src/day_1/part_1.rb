require_relative '../problem'
require_relative 'parse_input'

module Day1
  class Part1 < Problem
    extend Day1::Loader

    def self.run
      instructions = load_input

      start = 50
      min = 0
      max = 99
      range = min..max

      zero_count = 0

      current = start
      instructions.each do |instruction|
        case instruction.dir
        when Day1::Instruction::LEFT
          current = current - instruction.count
        when Day1::Instruction::RIGHT
          current = current + instruction.count
        end

        while current < min
          current += range.size
        end
        while current > max
          current -= range.size
        end

        if current == 0
          zero_count += 1
        end
      end

      zero_count
    end
  end
end
