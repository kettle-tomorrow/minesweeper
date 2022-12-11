require './board'
require './mines'

class Minesweeper
    def self.start
      board = Board.new(
        mine_count: 2,
        row_count: 3,
        column_count: 3,
      )

      puts "マインスイーパを開始します。"
      puts "爆弾は全部で#{2}個あります。"
      puts "回答を入力してください。(例: 1,1)"
      puts board.current_board

      loop do
        line = gets.split(',')
        row_input = line[0].to_i - 1
        column_input = line[1].to_i - 1
        if board.mine?(row_number: row_input, column_number: column_input)
          puts "爆弾です。"
          break 
        end
        board.open(row_number: row_input, column_number: column_input)

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
