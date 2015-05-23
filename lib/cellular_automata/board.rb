class CellularAutomata::Board
  attr_reader :width, :height, :rule
  def initialize(rule: 'B3S2', width: 80, height: 20)
    @rule   = rule
    @height = height
    @width  = width
    @array  = build_array
    CellularAutomata::Cell::array = @array
    parse_rule(rule)
    seed!
  end

  def to_s
    line = '+' << ('-' * width) << "+\n"
    ret = '' << line
    @array.each do |row|
      ret << "|"
      row.each do |cell|
        ret << cell.to_s
      end
      ret << "|\n"
    end
    ret << line
  end

  def tick!
    each_cell { |cell| cell.tick! }
  end

  private

  def parse_rule(rule)
    rules = rule.scan(/[BS]\d+/)
    raise ArgumentError.new('Invalid rule string') if rules.length != 2
    birth = rules.select {|s| s.start_with?('B')}.first
    survive = rules.select {|s| s.start_with?('S')}.first
    set_rules(birth: birth, survive: survive)
  end

  def set_rules(birth: , survive: )
    birth = birth[1..-1]
    survive = survive[1..-1]
    @birth = birth.split('').map(&:to_i)
    @survive = survive.split('').map(&:to_i)
    @death = ((0..8).to_a - @birth) - @survive
  end

  def each_cell
    (0..height-1).each do |y|
      (0..width-1).each do |x|
        yield @array[y][x]
      end
    end
  end

  def seed!
    each_cell { |c| c.live! if rand < 0.2 }
  end

  def build_array
    arr = []
    (0..height-1).each do |i|
      arr[i] = []
      (0..width-1).each do |j|
        arr[i][j] = CellularAutomata::Cell.new(row: i, column: j)
      end
    end
    return arr
  end
end

