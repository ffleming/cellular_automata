class CellularAutomata::Board
  attr_reader :width, :height
  def initialize(width: 80, height: 20)
    @height            = height
    @width             = width
    @array             = build_array
    CellularAutomata::Cell::array        = @array
    seed!
  end

  def to_s
    line = '+' << ('-' * width) << "+\n"
    ret = '' << line
    @array.each do |row|
      ret << "|"
      row.each do |cell|
        ret << cell.to_s
      end
      ret << "|\n"
    end
    ret << line
  end

  def cycle!
    each_cell do |cell|
      case cell.live_neighbors.length
      when 0..1
        cell.die!
      when 3
        cell.live!
      when 4..8
        cell.die!
      end
    end
  end

  def animate(steps=1000, refresh=0.1)
    (1..steps).each do |i|
      puts "\e[H\e[2J"
      cycle!
      puts self.to_s
      sleep refresh
    end
  end

  private

  def each_cell
    (0..height-1).each do |row|
      (0..width-1).each do |col|
        yield @array[row][col]
      end
    end

  end

  def seed!
    (0..height-1).each do |row|
      (0..width-1).each do |col|
        @array[row][col].live! if rand < 0.2
      end
    end
  end

  def build_array
    arr = []
    (0..height-1).each do |i|
      arr[i] = []
      (0..width-1).each do |j|
        arr[i][j] = CellularAutomata::Cell.new(row: i, column: j)
      end
    end
    return arr
  end
end

