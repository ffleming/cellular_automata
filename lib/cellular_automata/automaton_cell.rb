class CellularAutomata::AutomatonCell
  include CellularAutomata::Cell
  class << self
    attr_accessor :array
  end

  attr_accessor :row, :column, :organism, :rule
  attr_reader :alive
  alias x column
  alias x= column=
  alias y row
  alias y= row=
  alias alive? alive
  def initialize(rule: 'B3S2', row: , column: )
    @row = row
    @column = column
    @alive = false
    @organism = nil
  end

  def to_s
    return ' ' if @organism.nil?
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
    return false if @organism.nil?
    @organism.die!
  end

  def tick!
    adj_pop = cell.live_neighbors.length
    if @birth.include? adj_pop
      @organism.live!
    elsif @death.include? adj_pop
      @organism.kill!
    end
  end

  private

  def neighbors
    [ nw_neighbor, n_neighbor, ne_neighbor,
      w_neighbor,               e_neighbor,
      se_neighbor, s_neighbor, sw_neighbor ].compact
  end

  def n_neighbor
    neighbor(y-1, x)
  end

  def ne_neighbor
    neighbor(y-1, x+1)
  end

  def e_neighbor
    cell_at(y, x+1)
  end

  def se_neighbor
    cell_at(y+1, x+1)
  end

  def s_neighbor
    cell_at(y+1, x)
  end

  def sw_neighbor
    cell_at(y+1, x-1)
  end

  def w_neighbor
    cell_at(y, x+1)
  end

  def nw_neighbor
    cell_at(y-1, x-1)
  end

  def cell_at(r, c)
    raise StandardError.new("Cell::array not initialized") if CellularAutomata::Cell::array.nil?
    return nil if r  < 0 || c < 0 || r > height-1 || c > width-1
    return CellularAutomata::Cell::array[r][c] rescue nil
  end
end
