class CellWindow < Gosu::Window
  attr_reader :board, :scale, :cell_width, :paused
  alias paused? paused
  def initialize(opts={})
    @scale = opts[:scale]
    @cell_width = scale**opts[:cell_scale]
    super opts[:width]*scale, opts[:height]*scale, opts[:fullscreen]
    @board = CellularAutomata::Board.new(width: opts[:width]/scale, height: opts[:height]/scale, rule: opts[:rule])
    self.caption = "Cellular Automata"
  end

  def update
    board.tick! unless paused?
  end

  def draw
    board.each_cell do |cell|
      color = cell.alive? ? Gosu::Color::YELLOW : Gosu::Color::BLACK
      Gosu.draw_rect(cell.x * scale**2, cell.y * scale**2, cell_width, cell_width, color, 0, :default)
    end
  end

  def button_down(id)
    if id == Gosu::KbSpace
      toggle_pause
    else
      exit
    end
  end

  def toggle_pause
    @paused = !@paused
  end
end

