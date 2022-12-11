require './board'

class Minesweeper
    def self.start
      board = Board.new(
        mines: Mines.generate(mine_count: 2, x_max: 2, y_max: 2),
      )

      puts "マインスイーパを開始します。"
      puts "爆弾は全部で#{2}個あります。"
      puts "回答を入力してください。(例: 1,1)"
      puts board.current_board

      loop do
        line = gets.split(',')
        x = line[0].to_i - 1
        y = line[1].to_i - 1
        if board.mine?(row_number: x, squire_number: y)
          puts "爆弾です。"
          break 
        end
        board.open(row_number: x, squire_number: y)

        if board.completed?
          puts "---"
          puts "クリアです。"
          puts "---"
          puts board.completed_board
          break
        end

        puts "---"
        puts "次の回答を入力してください。"
        puts "---"

        puts board.current_board
      end

      puts "マインスイーパを終了します。"
    end
end
