## Advent of Code 2025 Solutions

Ruby solutions for the [Advent of Code 2025](https://adventofcode.com/2025) programming puzzles.

### Running

- **Install dependencies**: `bundle install`
- **Run a puzzle** (interactive day/part picker): `bundle exec ./run.rb`
- **Run a specific day/part**: `bundle exec ./run.rb --day 1 --part 1` (add `--example` to use `example_input.txt`)

### Adding a New Day

- **Create a directory**: `src/day_N` (for example, `src/day_2`)
- **Add input files**: by default `Problem` reads `input.txt` (and `example_input.txt` when `--example` is used); override `self.path_for(part:, example:)` in your `Problem` subclass if you want a different layout.
- **Define parts**: create `part_1.rb`, `part_2.rb`, etc., each defining `DayN::PartK < Problem`. For custom parsing, define a class method `self.parse_input(input, part: nil)` (signature is flexible) and `Problem.load_input` will pass the raw file content to it.

Example minimal implementation for day 2, part 1 (using the default input paths and a simple parser):

```ruby
# src/day_2/part_1.rb
require_relative '../problem'

module Day2
  class Part1 < Problem
    # Optional: customise how input.txt is parsed for this part
    def self.parse_input(input, part: nil, example: false)
      input.lines.map(&:chomp)
    end

    def self.run
      data = load_input
      # TODO: implement your solution here
      data.size
    end
  end
end
```
