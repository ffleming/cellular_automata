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
    board.each_cell do |x, y|
      prev_1 = board.history[0][y][x]
      prev_2 = board.history[1][y][x]
      color = Gosu::Color::BLACK
      if board.state[y][x]
        color = Gosu::Color.argb(0xff_FFFF00)
      elsif prev_1
        color = Gosu::Color.argb(0xff_AAAA00)
      elsif prev_2
        color = Gosu::Color.argb(0xff_444400)
      end
      Gosu.draw_rect(x * scale**2, y * scale**2, cell_width, cell_width, color, 0, :default)
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

