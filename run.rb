#! /usr/bin/env ruby

require "tty-prompt"
def __choose_day(prompt)
  prompt ||= TTY::Prompt.new
  days = Dir.glob("src/day_*").map { |day| day.split("/").last.sub("day_", "").to_i }
  if days.length > 1
    prompt.select("Choose a day", days)
  else
    puts "Only one day available, using #{days.first}"
    days.first
  end
end

def __choose_part(prompt, day)
  prompt ||= TTY::Prompt.new
  parts = Dir.glob("src/day_#{day}/part_*").map { |part| part.split("/").last.sub("part_", "").to_i }
  if parts.length > 1
    part = prompt.select("Choose a part", parts)
    part
  else
    puts "Only one part available, using #{parts.first}"
    parts.first
  end
end

def __run_day(day, part, example: false)
  require_relative "src/day_#{day}/part_#{part}"
  eval("Day#{day}::Part#{part}.call(example:)")
end

require 'optparse'
options = {}
OptionParser.new do |opts|
  opts.on("-e", "--example", "Use example input") do |v|
    options[:example] = true
  end

  opts.on("-d", "--day DAY", "Day to run - leave blank to choose") do |v|
    options[:day] = v.to_i
  end

  opts.on("-p", "--part PART", "Part to run - leave blank to choose") do |v|
    options[:part] = v.to_i
  end

  opts.on("-h", "--help", "Show help") do
    puts opts
    exit
  end
end.parse!

prompt = TTY::Prompt.new
day = options[:day] || __choose_day(prompt)
part = options[:part] || __choose_part(prompt, day)
result = __run_day(day, part, example: options[:example])
puts "Result: #{result}"
