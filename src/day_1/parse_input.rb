module Day1
  class Instruction < Struct.new(:dir, :count)
    LEFT = 'L'
    RIGHT = 'R'
  end
  module Loader
    def parse_input(input)
      input.split("\n").map do |line|
        dir = line[0]
        count = line[1..].to_i
        Instruction.new(dir, count)
      end
    end
  end
end
