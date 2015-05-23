class CellularAutomata::Cell
  class << self
    attr_accessor :array
  end

  attr_reader :row, :column, :organism
  alias x column
  alias y row
  def initialize(row: , column: )
    @row = row
    @column = column
    @organism = nil
    @birth = [3]
    @death = [0, 1,2,5,6,7,8]
  end

  def to_s
    return ' ' if @organism.nil? || @organism.dead?
    @organism.to_s
  end

  def live_neighbors
    neighbors.select {|n| n.organism && n.organism.alive? }
  end

  def live!
    if @organism.nil?
      @organism = CellularAutomata::Organism.new(home: self, alive: true)
    elsif @organism.dead?
      @organism.live!
    end
  end

  def kill!
    return if @organism.nil?
    @organism.die!
  end

  def tick!
    adj_pop = live_neighbors.length
    if @birth.include? adj_pop
      live!
    elsif @death.include? adj_pop
      kill!
    end
  end

  private

  def neighbors
    x_min = x == 0 ? 0 : x-1
    x_max = CellularAutomata::Cell::array[0].length - 1
    x_max = x + 1 if(x+1 < x_max)

    y_min = y == 0 ? 0 : y-1
    y_max = CellularAutomata::Cell::array.length - 1
    y_max = y + 1 if(y+1 < y_max)
    (y_min..y_max).each_with_object([]) do |y, ret|
      (x_min..x_max).each do |x|
        cell = cell_at(y,x)
        ret << cell unless cell.nil? || cell == self
      end
    end
  end

  def cell_at(y, x)
    raise StandardError.new("Cell::array not initialized") if CellularAutomata::Cell::array.nil?
    return nil if x  < 0 || y < 0
    return nil if y > CellularAutomata::Cell::array.length-1
    return nil if x > CellularAutomata::Cell::array[0].length-1
    return CellularAutomata::Cell::array[y][x]
  end

  def neighbors
    [ cell_at(y-1, x-1), cell_at(y-1, x  ), cell_at(y-1, x+1),
      cell_at(y,   x+1),                    cell_at(y  , x-1),
      cell_at(y+1, x-1), cell_at(y+1, x  ), cell_at(y+1, x+1) ].compact
  end

end
