class CellularAutomata::Cell
  class << self
    attr_accessor :array
  end

  attr_accessor :row, :column
  attr_reader :alive
  alias x column
  alias x= column=
  alias y row
  alias y= row=
  alias alive? alive
  def initialize(row: , column: )
    @row = row
    @column = column
    @alive = false
  end

  def die!
    @alive = false
  end

  def live!
    @alive = true
  end

  def dead?
    !alive?
  end

  def to_s
    return ' ' if dead?
    '*'
  end

  def live_neighbors
    neighbors.select {|n| n.alive? }
  end

  private

  def neighbors
    [
      n_neighbor,
      ne_neighbor,
      e_neighbor,
      se_neighbor,
      s_neighbor,
      sw_neighbor,
      w_neighbor,
      nw_neighbor
    ].compact
  end

  def n_neighbor
    neighbor(y-1, x)
  end

  def ne_neighbor
    neighbor(y-1, x+1)
  end

  def e_neighbor
    neighbor(y, x+1)
  end

  def se_neighbor
    neighbor(y+1, x+1)
  end

  def s_neighbor
    neighbor(y+1, x)
  end

  def sw_neighbor
    neighbor(y+1, x-1)
  end

  def w_neighbor
    neighbor(y, x+1)
  end

  def nw_neighbor
    neighbor(y-1, x-1)
  end

  def neighbor(r, c)
    raise StandardError.new("Cell::array not initialized") if CellularAutomata::Cell::array.nil?
    return nil if r  < 0 || c < 0
    return CellularAutomata::Cell::array[r][c] rescue nil
  end
end
