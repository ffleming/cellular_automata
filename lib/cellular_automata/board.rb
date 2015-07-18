class CellularAutomata::Board
  attr_reader :width, :height, :rule, :history, :state
  def initialize(rule: 'B3S2', width: 80, height: 20, max_history: 2)
    @height = height
    @width  = width
    @state  = build_array
    @rule   = CellularAutomata::Rule.new(rule)
    @history = []
    @max_history = max_history
    max_history.times { history.push build_array }
    seed!
  end

  def to_s
    line = '+' << ('-' * width) << "+\n"
    ret = '' << line
    @state.each do |row|
      ret << "|"
      row.each do |cell|
        ret << (cell == 0 ? ' ' : '*' )
      end
      ret << "|\n"
    end
    ret << line
  end

  def tick!
    next_state = CellularC.next_state(@state, rule)
    history.unshift CellularC.dup_state(@state)
    history.pop if history.length > @max_history
    @state = next_state
  end

  def kill(array: , x: , y: )
    array[y][x] = 0
  end

  def live(array: , x: , y: )
    array[y][x] = 1
  end

  def each_cell
    (0..height-1).each do |y|
      (0..width-1).each do |x|
        yield(x, y)
      end
    end
  end

  private

  def seed!
    each_cell { |x, y| @state[y][x] = 1 if rand < 0.1 }
  end

  def build_array
    arr = []
    (0..height-1).each do |y|
      arr[y] = []
      (0..width-1).each do |x|
        arr[y][x] = 0
      end
    end
    return arr
  end

  def neighbor_population_of(x: , y: )
    ret = 0
    min_x = x > 1 ? x - 1 : 0
    max_x = x < width - 2 ? x + 1 : width - 1
    min_y = y > 1 ? y - 1 : 0
    max_y = y < height - 2 ? y + 1 : height - 1
    (min_y..max_y).each do |row|
      (min_x..max_x).each do |col|
        ret += 1 unless ((x == col && y == row) || @state[row][col] == 0)
      end
    end
    ret
  end
end

