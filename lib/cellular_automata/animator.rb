module CellularAutomata::Animator
  class << self
    attr_reader :board
    def board
      @board ||= CellularAutomata::Board.new(width: 100, height: 30, rule: 'B3S124')
    end
    def animate(steps=100, refresh=0.1)
      (1..steps).each do
        puts "\e[H\e[2J"
        board.tick!
        puts board.to_s
        sleep refresh
      end
    end
  end
end
