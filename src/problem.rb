class Problem
  def self.parse_class_name(class_name)
    result = /Day(?<day>\d+)::(?:Part)(?<part>\d+)/.match(class_name)
    raise "Invalid class name: #{class_name}" unless result
    result.named_captures.transform_values(&:to_i).transform_keys(&:to_sym)
  end

  def self.inherited(subclass)
    parse_class_name(subclass.name)
  end

  def self.load_input
    input = File.read(file_path(part: self.part, example: @load_example)).chomp
    if respond_to?(:parse_input)
      m = method(:parse_input)
      arguments = [input]
      kwargs = {}

      parameters = m.parameters
      if parameter = parameters.find { |(type, name)| name == :part }
        if [:req, :opt].include?(parameter.first)
          arguments.push(part)
        elsif [:keyreq, :key].include?(parameter.first)
          kwargs[:part] = part
        end
      end

      input = m.call(*arguments, **kwargs)
    end
    input
  end
  def self.file_path(...)
    path = path_for(...)

    caller_location = caller_locations.find { |p| /day_\d+\/part_\d+/ =~ p.to_s }
    File.expand_path(path, File.dirname(caller_location.path))
  end
  def self.path_for(part:, example: false)
    if example
      "./example_input.txt"
    else
      "./input.txt"
    end
  end

  def self.call(example: false)
    @load_example = example
    self.run
  end

  def self.day
    @day ||= parse_class_name(self.name)[:day]
  end

  def self.part
    @part ||= parse_class_name(self.name)[:part]
  end
end
