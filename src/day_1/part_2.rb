require_relative '../problem'
require_relative 'parse_input'

module Day1
  class Part2 < Problem
    extend Day1::Loader

    def self.run
      instructions = load_input

      range = 0..99
      current = 50

      zero_count = 0
      instructions.each do |instruction|
        case instruction.dir
        when Day1::Instruction::LEFT
          instruction.count.times do
            current -= 1
            if current == 0
              zero_count += 1
            end
            if current < range.min
              current += range.size
            end
          end
        when Day1::Instruction::RIGHT
          instruction.count.times do
            current += 1
            if current > range.max
              current -= range.size
            end
            if current == 0
              zero_count += 1
            end
          end
        end
      end

      zero_count
    end
  end
end
