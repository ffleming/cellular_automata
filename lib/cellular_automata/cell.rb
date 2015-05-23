class CellularAutomata::Cell
  attr_reader :alive, :row, :column
  alias x column
  alias y row
  alias alive? alive
  def initialize(alive: false, row: , column:)
    @alive = alive
    @row = row
    @column = column
  end

  def to_s
    return ' ' if dead?
    '*'
  end

  def live!
    @alive = true
  end

  def die!
    @alive = false
  end

  def survive!
  end

  def dead?
    !alive?
  end

  def copy
    self.class.new(alive: alive?, row: row, column: column)
  end
end
