require_relative '../problem'

module Day8
  class Part1 < Problem
    def self.run
      junctions, connection_count = load_input

      dist_map = DistanceMap.new
      junctions.permutation(2).each do |a, b|
        next if dist_map[a, b]

        dist_map[a, b] = a.distance_from b
      end

      circuits = []

      shortest_connections = dist_map.entries.sort_by { it[1] }.map(&:first)
      shortest_connections[...connection_count].each do |(a, b)|
        a_circuit = circuits.find { |c| c.include? a }
        b_circuit = circuits.find { |c| c.include? b}

        if a_circuit && b_circuit
          next if a_circuit == b_circuit
          circuits.delete(b_circuit)
          a_circuit.concat(b_circuit)
        elsif a_circuit
          a_circuit.push b
        elsif b_circuit
          b_circuit.push a
        else
          circuits.push([a, b])
        end
      end

      three_largest_circuits = circuits.sort_by(&:length).reverse[...3]
      three_largest_circuits.map(&:length).reduce(&:*)
    end

    def self.parse_input(input, example:)
      values = input.lines.map { |l| l.split(',').map(&:to_i) }
      index_width = values.length.to_s.length
      widest = values.flatten.max.to_s.length

      [
        values.each_with_index.map do |v, i|
          Junction.new(*v, i, index_width, widest)
        end,
        example ? 10 : 1000
      ]
    end

    class Junction < Struct.new(:x, :y, :z, :index, :index_width, :value_width)
      def distance_from(junction)
        Math.sqrt(
          (x - junction.x).abs2 +
          (y - junction.y).abs2 +
          (z - junction.z).abs2
        )
      end

      def to_s
        pad = -> (v) { v.to_s.rjust(value_width) }
        "Junction #{index.to_s.rjust(index_width)} (#{pad.call(x)}, #{pad.call(y)}, #{pad.call(z)})"
      end
      alias :inspect :to_s
    end

    class DistanceMap < Hash
      def [](a, b)
        super([a, b].sort_by(&:index))
      end

      def []=(a, b, v)
        super([a, b].sort_by(&:index), v)
      end
    end
  end
end
