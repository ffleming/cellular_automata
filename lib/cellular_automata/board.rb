class CellularAutomata::Board
  attr_reader :width, :height, :rule, :history
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
        ret << cell.to_s
      end
      ret << "|\n"
    end
    ret << line
  end

  def tick!
    next_state = Marshal.load(Marshal.dump @state)
    each_cell do |cell|
      next_state[cell.y][cell.x].send rule.process(neighbor_population_of cell) #= next_cell #cell.send(rule.process(adj_pop))
    end
    history.unshift Marshal.load(Marshal.dump @state)
    history.pop if history.length > @max_history
    @state = next_state
  end

  def each_cell
    (0..height-1).each do |y|
      (0..width-1).each do |x|
        yield @state[y][x]
      end
    end
  end

  private

  def seed!
    each_cell { |c| c.live! if rand < 0.1 }
  end

  def build_array
    arr = []
    (0..height-1).each do |y|
      arr[y] = []
      (0..width-1).each do |x|
        arr[y][x] = CellularAutomata::Cell.new(row: y, column: x, alive: false)
      end
    end
    return arr
  end

  def neighbor_population_of(cell)
    neighbors_of(cell).select(&:alive?).length
  end

  def cell_at(y, x)
    return nil if x  < 0 || y < 0
    return nil if y > @state.length-1
    return nil if x > @state[0].length-1
    return @state[y][x]
  end

  def neighbors_of(cell)
    y = cell.y ; x = cell.x
    [ cell_at(y-1, x-1), cell_at(y-1, x  ), cell_at(y-1, x+1),
      cell_at(y,   x+1),                    cell_at(y  , x-1),
      cell_at(y+1, x-1), cell_at(y+1, x  ), cell_at(y+1, x+1) ].compact
  end

end

