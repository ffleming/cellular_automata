module CellularAutomata::Animator
  class << self
    attr_accessor :board
    def board
      @board ||= CellularAutomata::Board.new(width: 120, height: 30)
    end
    def animate(steps=1000, refresh=0.1)
      (1..steps).each do
        puts "\e[H\e[2J"
        board.cycle!
        puts board.to_s
        sleep refresh
      end
    end
  end
end
