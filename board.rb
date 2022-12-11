class Board
  attr_reader :rows

  def initialize(mines:)
    x1 = [{ d: "■", n: 0, m: false }, { d: "■", n: 0, m: false }, { d: "■", n: 0, m: false }]
    x2 = [{ d: "■", n: 0, m: false }, { d: "■", n: 0, m: false }, { d: "■", n: 0, m: false }]
    x3 = [{ d: "■", n: 0, m: false }, { d: "■", n: 0, m: false }, { d: "■", n: 0, m: false }]
    b = [x1, x2, x3]

    mine1 = mines[0]
    mine2 = mines[1]

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

    @rows = b
  end

  def current_board
    rows.map { |row| row.map { |squire| squire[:d] }.join(" ") }
  end

  def is_mine?(row_number:, squire_number:)
    rows[row_number-1][squire_number-1][:m] == true
  end
end