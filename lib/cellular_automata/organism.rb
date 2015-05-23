class CellularAutomata::Organism
  attr_accessor :alive, :home
  alias alive? alive
  def initialize(home: , alive: false)
    @home  = home
    @alive = !!alive
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

end
