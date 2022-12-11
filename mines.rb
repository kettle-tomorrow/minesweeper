class Mines
  def self.generate(mine_count:, row_max:, column_max:)
    mines = []
    mine_count.times do
      mine = [rand(0..row_max), rand(0..column_max)]
      loop do
        break unless mines.include?(mine)
        mine = [rand(0..row_max), rand(0..column_max)]
      end
      mines << mine
    end
    mines
  end
end
