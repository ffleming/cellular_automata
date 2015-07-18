class CellularAutomata::Rule
  def initialize(rule_string)
    rules = rule_string.downcase.scan(/[bs]\d+/)
    raise ArgumentError.new("Invalid rule string #{rule_string}") if rules.length != 2
    birth = rules.select {|s| s.start_with?('b')}.first
    survive = rules.select {|s| s.start_with?('s')}.first
    @rule_array = rules_array_from birth: birth, survive: survive
  end

  def process(input)
    return @rule_array[input.to_i] || raise(ArgumentError.new("I don't know what to do with #{input.class} #{input}"))
  end

  private

  def rules_array_from(birth: , survive: )
    ('0'..'8').each_with_object([]) do |i_str, ret|
      val = :die
      val = :survive if survive.include? i_str
      val = :birth if birth.include? i_str
      ret << val
    end
  end
end
