require './board'

class Minesweeper
    def self.start
        mine1 = [rand(0..2), rand(0..2)]
        mine2 = [rand(0..2), rand(0..2)]

        loop do
          break if mine1 != mine2
          mine2 = [rand(0..2), rand(0..2)]
        end
        board = Board.new(mines: [mine1, mine2])
        
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
                puts board.rows.map { |x| x.map { |s| s[:m] == true ? "✖" : s[:d] }.join(" ") }
                break
            end

            puts "---"
            puts "次の回答を入力してください。"
            puts "---"

            puts board.rows.map { |x| x.map { |y| y[:d] }.join(" ") }
        end

        puts "マインスイーパを終了します。"
    end
end
