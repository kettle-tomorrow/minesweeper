class Mines
  def self.generate(mine_count:, x_max:, y_max:)
    mines = []
    mine_count.times do
      mine = [rand(0..x_max), rand(0..y_max)]
      loop do
        break unless mines.include?(mine)
        mine = [rand(0..x_max), rand(0..y_max)]
      end
      mines << mine
    end
    mines
  end
end
