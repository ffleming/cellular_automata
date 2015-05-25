module CellularAutomata::GifWriter
  class << self
  def write(opts={})
    @scale = opts[:scale]
    @cell_width = scale**opts[:cell_scale]
    @board = CellularAutomata::Board.new(width: opts[:width]/scale, height: opts[:height]/scale, rule: opts[:rule])
    @gif = Magick::ImageList.new
    @width = opts[:width]
    @height = opts[:height]
    @frames = opts[:frames]
    write_gif('test.gif')
  end

  private

  attr_reader :board, :scale, :cell_width, :frames, :writer, :height, :width

  def write_gif(outfile)
    frames.times do |i|
      draw_frame
      board.tick!
    end
    @gif.write(outfile)
  end

  def draw_frame
    writer = Magick::Draw.new
    frame = Magick::Image.new(width, height) do
      self.background_color = '#000000'
    end
    board.each_cell do |cell|
      prev_1 = board.history[0][cell.y][cell.x]
      prev_2 = board.history[1][cell.y][cell.x]
      color = '#000000'
      if cell.alive?
        color = '#FFFF00'
      elsif prev_1.alive?
        color = '#AAAA00'
      elsif prev_2.alive?
        color = '#444400'
      end
      writer.stroke color
      writer.fill color
      x1 = cell.x * scale**2
      y1 = cell.y * scale**2
      x2 = x1 + cell_width
      y2 = y1 + cell_width
      writer.rectangle(x1, y1, x2, y2)
    end
    writer.draw(frame)
    @gif << frame
    print '.'
  end
  end
end

