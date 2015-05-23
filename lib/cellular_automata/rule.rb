class CellularAutomata::Rule
  def initialize(rule_string)
    @rule_hash = process_rule! rule_string
  end

  def process(input)
    return @rule_hash[input] || raise(ArgumentError.new("I don't know what to do with #{input.class} #{input}"))
  end

  def process2(input)
    @rule_hash[input] != :die!
  end

  private

  def process_rule!(rule_string)
    rules = rule_string.scan(/[BS]\d+/)
    raise ArgumentError.new("Invalid rule string #{rule_string}") if rules.length != 2
    birth_string = rules.select {|s| s.start_with?('B')}.first
    survive_string = rules.select {|s| s.start_with?('S')}.first
    (birth, survive) = [birth_string, survive_string].map { |s| s[1..-1].split('').map(&:to_i) }
    death = ((0..8).to_a - birth) - survive
    {live!: birth, survive!: survive, die!: death}.each_with_object({}) do |(k, v), ret|
      v.each {|int| ret[int] = k}
    end
  end
end
