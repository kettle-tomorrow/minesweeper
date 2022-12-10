class Minesweeper
    def self.start
        x1 = [{ d: "■", n: 0, m: false, f: false }, { d: "■", n: 0, m: false, f: false }, { d: "■", n: 0, m: false, f: false }]
        x2 = [{ d: "■", n: 0, m: false, f: false }, { d: "■", n: 0, m: false, f: false }, { d: "■", n: 0, m: false, f: false }]
        x3 = [{ d: "■", n: 0, m: false, f: false }, { d: "■", n: 0, m: false, f: false }, { d: "■", n: 0, m: false, f: false }]
        b = [x1, x2, x3]

        mine1 = [rand(0..2), rand(0..2)]
        mine2 = [rand(0..2), rand(0..2)]
        loop do
            break if mine1 != mine2
            mine2 = [rand(0..2), rand(0..2)]
        end
        b[mine1[0]][mine1[1]][:m] = true
        b[mine2[0]][mine2[1]][:m] = true

        (0..2).each do |i|
            (0..2).each do |j|
                if b[i][j][:m] == false
                    top = i - 1
                    down = i + 1
                    left = j - 1
                    right = j + 1
                    if top >= 0
                        b[i][j][:n] += 1 if b[top][j][:m] == true
                    end
                    if down <= 2
                        b[i][j][:n] += 1 if b[down][j][:m] == true
                    end
                    if left >= 0
                        b[i][j][:n] += 1 if b[i][left][:m] == true
                    end
                    if right <= 2
                        b[i][j][:n] += 1 if b[i][right][:m] == true
                    end
                    top_left = [top, left]
                    top_right = [top, right]
                    down_left = [down, left]
                    down_right = [down, right]
                    if top_left[0] >= 0 && top_left[1] >= 0
                        b[i][j][:n] += 1 if b[top_left[0]][top_left[1]][:m] == true
                    end
                    if top_right[0] >= 0 && top_right[1] <= 2
                        b[i][j][:n] += 1 if b[top_right[0]][top_right[1]][:m] == true
                    end
                    if down_left[0] <= 2 && down_left[1] >= 0
                        b[i][j][:n] += 1 if b[down_left[0]][down_left[1]][:m] == true
                    end
                    if down_right[0] <= 2 && down_right[1] <= 2
                        b[i][j][:n] += 1 if b[down_right[0]][down_right[1]][:m] == true
                    end
                end
            end
        end
        
        puts "マインスイーパを開始します。"
        puts "爆弾は全部で#{2}個あります。"
        puts "回答を入力してください。(例: 1,1)"
        puts b.map { |x| x.map { |s| s[:d] }.join(" ") }

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
