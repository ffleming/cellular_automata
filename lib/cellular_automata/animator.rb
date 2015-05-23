module CellularAutomata::Animator
  class << self
    attr_reader :board
    def board
      @board ||= CellularAutomata::Board.new(width: 120, height: 30, rule: 'B3S12345')
    end
    def animate(steps=1000, refresh=0.1)
      (1..steps).each do
        puts "\e[H\e[2J"
        board.tick!
        puts board.to_s
        sleep refresh
      end
    end
  end
end
