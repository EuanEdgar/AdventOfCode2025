require_relative '../problem'

module Day7
  SOURCE = 'S'
  EMPTY = '.'
  SPLITTER = '^'

  class Part1 < Problem
    def self.run
      start, *lines = load_input

      start_column = start.index(SOURCE)
      puts "Splitter found at index #{start_column} of #{start.length - 1}"

      beams = Set.new([start_column])

      puts "Initial beam array:"
      puts beams.to_a.to_s

      splits = 0
      lines.each_with_index do |line, index|
        puts "Line #{index + 1}"
        print beams, line

        relevant_splitters = beams.select { |i| line[i] == SPLITTER }
        relevant_splitters.each do |index|
          beams.delete index
          [index - 1, index + 1].each { |i| beams.add i }
          splits += 1
        end
      end

      splits
    end

    def self.parse_input(input)
      input.lines.map do |line|
        line.chars.map do |char|
          case char
          when SOURCE
            SOURCE
          when SPLITTER
            SPLITTER
          when EMPTY
            nil
          end
        end
      end
    end

    def self.print(beams, line)
      width = line.length
      number_width = width.to_s.length
      j = -> (a) { a.map { it.to_s.rjust(number_width) }.join ' '}

      puts "      #{j.call width.times.to_a}"
      puts "Beams #{j.call width.times.map { beams.include?(it) ? '|' : ' ' }}"
      puts "Split #{j.call line.map { it || ' ' }}"
    end
  end
end
