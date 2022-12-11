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
        puts board.render_current_squires

        b = board.squires

        loop do
            line = gets.split(',')
            x = line[0].to_i
            y = line[1].to_i
            if b[x-1][y-1][:m] == true
                puts "爆弾です。"
                break 
            end
            b[x-1][y-1][:d] = b[x-1][y-1][:n]

            cl = b.all? do |x|
                x.all? do |h|
                    h[:d] != "■" || h[:m] == true
                end
            end

            if cl == true
                puts "---"
                puts "クリアです。"
                puts "---"
                puts b.map { |x| x.map { |s| s[:m] == true ? "✖" : s[:d] }.join(" ") }
                break
            end

            puts "---"
            puts "次の回答を入力してください。"
            puts "---"

            puts b.map { |x| x.map { |y| y[:d] }.join(" ") }
        end

        puts "マインスイーパを終了します。"
    end
end
